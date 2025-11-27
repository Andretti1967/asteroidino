/*
 * main.cpp - Asteroids Arcade Emulator für ESP32
 * 
 * (c) 2025 - Basierend auf Galagino von Till Harbaum
 * 
 * Hardware:
 * - ESP32-WROOM Development Board
 * - MCP4922 Dual DAC für X/Y Vektor-Ausgabe (SPI)
 * - PCM5102A I2S DAC für Audio
 * - 7 GPIO Buttons (Rotate L/R, Thrust, Hyperspace, Fire, Start, Coin)
 */

#include <Arduino.h>
#include "config.h"
#include <cpu6502.h>
#include <vector_dac.h>
#include <esp_task_wdt.h>  // For watchdog timer control

// ROMs konvertiert - inkludiere sie
#define ASTEROID_ROMS_CONVERTED
#include "asteroid_roms.h"
#include "dvg_prom.h"

// ============================================================================
// GLOBAL STATE
// ============================================================================

mos6502* cpu = nullptr;
VectorDAC vector_dac;

// Memory
uint8_t ram[MEM_SIZE_RAM];          // 0x0000-0x0FFF
uint8_t vector_ram[MEM_SIZE_VECTOR]; // 0x4000-0x47FF
// ROMs werden aus den inkludierten Arrays geladen

// Vector display state
struct {
    uint16_t points[VECT_POINTS_PER_FRAME][2];  // X, Y pairs
    uint8_t  intensity[VECT_POINTS_PER_FRAME];  // Brightness
    int      count;
} vector_buffer;

// DVG frame counter for debugging
int dvg_frame_count = 0;

// DVG state machine (MAME-style with PROM)
struct {
    uint16_t pc;           // Program counter in vector RAM
    int16_t  x, y;         // Current beam position
    int16_t  xpos, ypos;   // Position counters (10-bit with overflow)
    uint8_t  scale;        // Current scale factor (0-15)
    uint8_t  intensity;    // Current intensity (0-15)
    uint16_t dvx, dvy;     // Delta X and Y (12-bit signed)
    uint8_t  op;           // Current opcode from vector RAM
    uint16_t data;         // Current data word from vector RAM
    uint8_t  state_latch;  // PROM state latch (4 bits + halt flag)
    uint16_t stack[4];     // Subroutine stack
    uint8_t  stack_ptr;    // Stack pointer
    bool     halt;         // Halt flag
    bool     running;      // DVG is processing
} dvg_state;

// Input state
struct {
    bool rotate_left;
    bool rotate_right;
    bool thrust;
    bool hyperspace;
    bool fire;
    bool start;
    bool coin;
} buttons;

// DIP switch settings (DSW1) - MAME default Asteroids settings
// Bit 0-1: Language (00=English, 01=German, 10=French, 11=Spanish)
// Bit 2:   Lives (0=4 ships, 1=3 ships)
// Bit 3:   Center Mech (0=x1, 1=x2)
// Bit 4-5: Right Mech (00=x1, 01=x4, 10=x5, 11=x6)
// Bit 6-7: Coinage (00=Free Play, 01=1C/2C, 10=1C/1C, 11=2C/1C)
// MAME default: 0x84 = 10000100 (English, 3 ships, 1C/1C)
uint8_t dip_switches = 0x84;  // CORRECTED: English=00, Lives=3, Coinage=1C/1C

// 3 kHz clock signal (bit 1 of IN0) - toggled by CPU cycle count
bool clock_3khz = false;

// Task handles for dual-core
TaskHandle_t emulation_task_handle;

// IRQ/Interrupt state
volatile bool irq_pending = false;
unsigned long last_irq_time = 0;

// Total CPU cycle counter for clock signal generation
uint64_t total_cpu_cycles = 0;

// ============================================================================
// DVG (DIGITAL VECTOR GENERATOR) STATE MACHINE
// ============================================================================

/*
 * DVG Commands (from MAME avgdvg.cpp):
 * 
 * Vector RAM contains 16-bit words with the following formats:
 * 
 * VCTR (Vector): Draw a vector
 *   Word 0: yyyy yyyy yyyy SSSS  (Y delta + scale)
 *   Word 1: xxxx xxxx xxxx ZZZZ  (X delta + intensity)
 *   S = scale (0-15), Z = intensity (0-15)
 *   x/y = signed 13-bit deltas
 * 
 * LABS (Load Absolute): Set absolute position
 *   Word 0: 0010 YYYY YYYY YYYY  (Y position 0-1023)
 *   Word 1: xxxx xxxx xxxx xxxx  (X position 0-1023)
 * 
 * HALT: Stop processing
 *   Word: 0010 0000 0000 0000
 * 
 * JSRL (Jump Subroutine): Call subroutine
 *   Word: 0100 AAAA AAAA AAAA  (Address in vector RAM)
 * 
 * RTSL (Return Subroutine): Return from subroutine
 *   Word: 0101 0000 0000 0000
 * 
 * JMPL (Jump): Unconditional jump
 *   Word: 0110 AAAA AAAA AAAA  (Address in vector RAM)
 * 
 * SVEC (Short Vector): Short vector (2-bit scale, 3-bit deltas)
 *   Word: 111Y YYXX XzzS S000  (compact format)
 */

void dvg_add_vector(int16_t dx, int16_t dy, uint8_t intensity) {
    // Debug logging (first 20 calls)
    static int debug_calls = 0;
    if (debug_calls < 20) {
        Serial.printf("DVG_ADD_VECTOR[%d]: dx=%d, dy=%d, I=%d, state.x=%d, state.y=%d\n",
            debug_calls++, dx, dy, intensity, dvg_state.x, dvg_state.y);
    }
    
    if (vector_buffer.count >= VECT_POINTS_PER_FRAME) {
        return;  // Buffer full
    }
    
    // Add starting point if this is the first vector
    if (vector_buffer.count == 0) {
        vector_buffer.points[0][0] = dvg_state.x;
        vector_buffer.points[0][1] = dvg_state.y;
        vector_buffer.intensity[0] = 0;  // Starting point has no intensity
        vector_buffer.count = 1;
    }
    
    // Update position
    dvg_state.x += dx;
    dvg_state.y += dy;
    
    // Clip to screen bounds (0-1023)
    if (dvg_state.x < 0) dvg_state.x = 0;
    if (dvg_state.x > 1023) dvg_state.x = 1023;
    if (dvg_state.y < 0) dvg_state.y = 0;
    if (dvg_state.y > 1023) dvg_state.y = 1023;
    
    // Add endpoint
    vector_buffer.points[vector_buffer.count][0] = dvg_state.x;
    vector_buffer.points[vector_buffer.count][1] = dvg_state.y;
    vector_buffer.intensity[vector_buffer.count] = intensity;
    vector_buffer.count++;
    
    // CSV logging of DVG vector output (first 5000 vectors)
    static int vec_log_count = 0;
    static bool vec_csv_header = false;
    
    if (vec_log_count < 5000) {
        if (!vec_csv_header) {
            Serial.println("\n=== DVG VECTOR OUTPUT (10-bit coords, 4-bit intensity) ===");
            Serial.println("X,Y,Intensity");
            vec_csv_header = true;
        }
        
        Serial.printf("%d,%d,%d\n", dvg_state.x, dvg_state.y, intensity);
        vec_log_count++;
    }
}

void dvg_process_vector() {
    // VCTR: Draw vector
    // Scale determines step size: 2^(scale+1) steps
    int scale_val = (2 << dvg_state.scale) & 0x7ff;
    
    // Convert 12-bit signed values to actual deltas
    int16_t dx = (dvg_state.dvx & 0x400) ? (dvg_state.dvx | 0xF800) : (dvg_state.dvx & 0x3FF);
    int16_t dy = (dvg_state.dvy & 0x400) ? (dvg_state.dvy | 0xF800) : (dvg_state.dvy & 0x3FF);
    
    // Scale the deltas
    dx = (dx * scale_val) >> 8;
    dy = (dy * scale_val) >> 8;
    
    dvg_add_vector(dx, dy, dvg_state.intensity);
}

// Helper: Calculate PROM address from state_latch, opcode, and halt
uint8_t dvg_state_addr() {
    // MAME: addr = ((((state_latch >> 4) ^ 1) & 1) << 7) | (state_latch & 0xf)
    // If OP3 is set, add opcode bits
    uint8_t addr = ((((dvg_state.state_latch >> 4) ^ 1) & 1) << 7) | (dvg_state.state_latch & 0x0f);
    
    // OP3 check: bit 3 of OPCODE (not state_latch!)
    if (dvg_state.op & 0x08) {
        addr |= ((dvg_state.op & 7) << 4);
    }
    
    return addr;
}

// Helper: Update data bus (read word from Vector RAM/ROM)
void dvg_update_databus() {
    // DVG uses low bit of state for address (byte selection)
    uint16_t dvg_addr = dvg_state.pc;
    uint16_t byte_addr = (dvg_addr << 1) + (dvg_state.state_latch & 1);
    
    if (dvg_addr < 0x400) {
        // Read from Vector RAM
        if (byte_addr < 2048) {
            dvg_state.data = vector_ram[byte_addr];
        } else {
            dvg_state.data = 0x00;
        }
    } else if (dvg_addr < 0x800) {
        // Read from Vector ROM
        uint16_t rom_offset = (dvg_addr - 0x400) * 2 + (dvg_state.state_latch & 1);
        if (rom_offset < 2048) {
            dvg_state.data = pgm_read_byte(&asteroid_rom_vector[rom_offset]);
        } else {
            dvg_state.data = 0x00;
        }
    } else {
        dvg_state.data = 0x00;
    }
    // NOTE: MAME's update_databus() ONLY reads the byte into m_data
    // It does NOT update Op or DVY - those are handled by Handler 4/5
}

// Forward declaration
int dvg_handler_7();

// DVG Handler 0: DMAPUSH (push to stack)
int dvg_handler_0() {
    uint8_t op0 = dvg_state.op & 1;
    if (!op0) {
        dvg_state.stack_ptr = (dvg_state.stack_ptr + 1) & 0xf;
        dvg_state.stack[dvg_state.stack_ptr & 3] = dvg_state.pc;
    }
    return 0;
}

// DVG Handler 1: DMALD (load from stack or jump)
int dvg_handler_1() {
    uint8_t op0 = dvg_state.op & 1;
    if (op0) {
        // RTSL - Return from subroutine
        dvg_state.pc = dvg_state.stack[dvg_state.stack_ptr & 3];
        dvg_state.stack_ptr = (dvg_state.stack_ptr - 1) & 0xf;
    } else {
        // JSRL/JMPL - Jump to address in DVY (NO SHIFT - already word address!)
        dvg_state.pc = dvg_state.dvy;
    }
    return 0;
}

// DVG Handler 2: GOSTROBE (draw vector)
int dvg_handler_2() {
    // This draws the actual vector - simplified for now
    dvg_process_vector();
    return 0;
}

// DVG Handler 3: HALTSTROBE (halt if OP0 clear)
int dvg_handler_3() {
    uint8_t op0 = dvg_state.op & 1;
    dvg_state.halt = !op0;
    
    if (!op0) {
        dvg_state.xpos = dvg_state.dvx & 0xfff;
        dvg_state.ypos = dvg_state.dvy & 0xfff;
        dvg_add_vector(0, 0, 0);  // Draw to final position
    }
    return 0;
}

// DVG Handler 4: LATCH0 (latch low byte)
int dvg_handler_4() {
    dvg_state.dvy &= 0xf00;
    if (dvg_state.op == 0xf)
        dvg_handler_7(); // Special case from MAME
    else
        dvg_state.dvy = (dvg_state.dvy & 0xf00) | dvg_state.data;
    
    dvg_state.pc++;
    return 0;
}

// DVG Handler 5: LATCH1 (latch opcode and high Y)
int dvg_handler_5() {
    dvg_state.dvy = (dvg_state.dvy & 0xff) | ((dvg_state.data & 0xf) << 8);
    dvg_state.op = dvg_state.data >> 4;
    
    if (dvg_state.op == 0xf) {
        dvg_state.dvx &= 0xf00;
        dvg_state.dvy &= 0xf00;
    }
    return 0;
}

// DVG Handler 6: LATCH2 (latch low X and scale)
int dvg_handler_6() {
    dvg_state.dvx &= 0xf00;
    if (dvg_state.op != 0xf) {
        dvg_state.dvx = (dvg_state.dvx & 0xf00) | dvg_state.data;
    }
    
    uint8_t op1 = (dvg_state.op >> 1) & 1;
    uint8_t op3 = (dvg_state.op >> 3) & 1;
    if (op1 && op3) {
        dvg_state.scale = dvg_state.intensity;
    }
    
    dvg_state.pc++;
    return 0;
}

// DVG Handler 7: LATCH3 (latch high X and intensity)
int dvg_handler_7() {
    dvg_state.dvx = (dvg_state.dvx & 0xff) | ((dvg_state.data & 0xf) << 8);
    dvg_state.intensity = dvg_state.data >> 4;
    return 0;
}

void dvg_run_state_machine() {
    if (!dvg_state.running) return;
    
    static int debug_count = 0;
    static int last_frame_debugged = -1;
    extern int dvg_frame_count;
    
    if (dvg_frame_count != last_frame_debugged) {
        debug_count = 0;
        last_frame_debugged = dvg_frame_count;
    }
    
    bool debug = (dvg_frame_count == 12 && debug_count < 50); // Debug frame 12 (has E2 data)
    
    if (dvg_frame_count == 12 && debug_count == 0) {
        Serial.printf("\n=== DVG PROM-BASED STATE MACHINE: Frame %d ===\n", dvg_frame_count);
    }
    
    dvg_state.halt = false;
    int max_iterations = 1000;
    int cycles = 0;
    
    if (debug) {
        Serial.printf("DVG State Machine Start: PC=0x%03X, state_latch=0x%02X\n",
            dvg_state.pc, dvg_state.state_latch);
    }
    
    while (!dvg_state.halt && max_iterations-- > 0 && cycles < 10000) {
        // PROM-based state machine (MAME-style)
        // Calculate PROM address
        uint8_t prom_addr = dvg_state_addr();
        uint8_t prom_data = dvg_prom_read(prom_addr);
        
        // Get next state from PROM (034602-01.c8)
        uint8_t old_latch = dvg_state.state_latch;
        dvg_state.state_latch = (dvg_state.state_latch & 0x10) | (prom_data & 0x0f);
        
        if (debug && cycles < 20) {
            Serial.printf("  [%d] PROM[0x%02X]=0x%X → latch:0x%02X→0x%02X ST3=%d\n",
                cycles, prom_addr, prom_data, old_latch, dvg_state.state_latch,
                (dvg_state.state_latch & 0x08) ? 1 : 0);
        }
        
        // ST3 check: if bit 3 is set, update databus and execute handler
        if (dvg_state.state_latch & 0x08) {
            dvg_update_databus();
            
            uint8_t handler = dvg_state.state_latch & 0x07;
            if (debug && debug_count < 50) {
                Serial.printf("  Handler %d: PC:%03X Op:%X Data:%02X\n", 
                    handler, dvg_state.pc, dvg_state.op, dvg_state.data);
            }
            
            // Decode state and call appropriate handler
            switch (handler) {
                case 0: cycles += dvg_handler_0(); break;  // DMAPUSH
                case 1: cycles += dvg_handler_1(); break;  // DMALD
                case 2: cycles += dvg_handler_2(); break;  // GOSTROBE
                case 3: cycles += dvg_handler_3(); break;  // HALTSTROBE
                case 4: cycles += dvg_handler_4(); break;  // LATCH0
                case 5: cycles += dvg_handler_5(); break;  // LATCH1
                case 6: cycles += dvg_handler_6(); break;  // LATCH2
                case 7: cycles += dvg_handler_7(); break;  // LATCH3
            }
            
            if (debug && debug_count < 50) {
                debug_count++;
            }
        }
        
        cycles++;
    }  // end while
    
    if (debug_count < 10) debug_count++;
    
    dvg_state.running = false;
    
    // CSV output ONLY for DVG GO #12 (frame with E2 data - correct JSRL)
    extern int dvg_frame_count;
    
    if (dvg_frame_count == 12) {
        static bool header_printed = false;
        if (!header_printed) {
            Serial.println("\n========================================");
            Serial.println("=== DVG GO #12: COMPLETE FRAME ===");
            Serial.println("=== Format: X,Y,Intensity (10-bit coords 0-1023, 4-bit intensity 0-15) ===");
            Serial.println("========================================");
            header_printed = true;
        }
        
        // Output ALL vectors from this frame
        for (int i = 0; i < vector_buffer.count; i++) {
            int dvg_x = (vector_buffer.points[i][0] * 1023) / 4095;
            int dvg_y = (vector_buffer.points[i][1] * 1023) / 4095;
            int intensity = (vector_buffer.intensity[i] * 15) / 255;
            
            Serial.printf("%d,%d,%d\n", dvg_x, dvg_y, intensity);
        }
        
        Serial.println("========================================");
        Serial.printf("=== TOTAL VECTORS: %d ===\n", vector_buffer.count);
        Serial.println("========================================");
    }
    
    // Show summary (first 10 only to reduce spam)
    static int summary_count = 0;
    if (summary_count++ < 10) {
        Serial.printf("*** DVG finished: vectors=%d, halt=%d, PC=0x%04X\n", 
                     vector_buffer.count, dvg_state.halt, dvg_state.pc);
    }
}// ============================================================================
// MEMORY ACCESS (called by CPU emulator)
// ============================================================================

uint8_t cpu6502_read_callback(uint16_t addr) {
    // RAM: 0x0000-0x0FFF
    if (addr < 0x1000) {
        // DEBUG: Track Zero Page 0x5B (used by bit-shift loop at PC 0x6811)
        static int zp5b_read_count = 0;
        if (addr == 0x5B && zp5b_read_count < 30) {
            Serial.printf("*** ZP[0x5B] READ #%d: value=0x%02X, PC=0x%04X\n",
                         ++zp5b_read_count, ram[0x5B], cpu->GetPC());
        }
        return ram[addr];
    }
    
    // Vector RAM: 0x4000-0x47FF
    if (addr >= 0x4000 && addr < 0x4800) {
        return vector_ram[addr - 0x4000];
    }
    
    // Vector ROM: 0x5000-0x57FF (2KB with vector object data)
    if (addr >= 0x5000 && addr < 0x5800) {
        static bool first_read = true;
        if (first_read) {
            first_read = false;
            Serial.printf("*** First Vector ROM read at 0x%04X\n", addr);
        }
        return asteroid_rom_vector[addr - 0x5000];
    }
    
    // Input ports: 0x2000-0x2FFF
    // IN0: 0x2000-0x2007 (each address bit-selects one input)
    if (addr >= 0x2000 && addr < 0x2008) {
        static int read_count = 0;
        
        bool debug = false;  // Other debug disabled
        if (debug) {
            read_count++;
        }
        
        // Read all inputs from buttons struct
        uint8_t in0 = 0x00;
        if (buttons.hyperspace)  in0 |= 0x08;  // Bit 3
        if (buttons.fire)        in0 |= 0x10;  // Bit 4
        // Bit 5: Diagnostic Step (not implemented)
        // Bit 6: TILT (not implemented)
        // Bit 7: Self-Test Switch - Always 0 for normal gameplay
        
        // NORMAL GAMEPLAY MODE: bit 7 = 0
        // Leave bit 7 = 0 to run normal game code
        //
        // Reset handler at 0x7D08:
        //   LDY $2007    ; Load IN0 bit 7
        //   BMI L7D50    ; If bit 7=1, branch to self-test
        //   Falls through to JMP $6803 (normal game init at 0x6803)
        //
        // With NMI disabled, the main game code should be able to run
        // and eventually write to DVG GO (0x3000)
        // Bit 7 = 0 (normal mode, NOT self-test)
        
        // Bit 1: 3 kHz clock - toggle based on CPU cycles
        clock_3khz = (total_cpu_cycles & 0x100) ? true : false;
        if (clock_3khz) in0 |= 0x02;
        
        // Bit 2: DVG HALT (ACTIVE-LOW per schematics)
        // HALT=0 → DVG is DONE/ready (signal LOW)
        // HALT=1 → DVG is BUSY (signal HIGH)
        //
        // ROM at PC=0x6815: LDA $0x2002; BMI loop
        // - Reads bit 2 of IN0, returns as bit 7 of result
        // - BMI branches if bit 7=1 (negative)
        // - Waits until bit 7=0 (positive) to continue
        //
        // Bit-select logic: bit_value = (in0 >> 2) & 0x01
        //                   result = bit_value ? 0x80 : 0x7F
        //
        // For DVG DONE (HALT=0, active-low):
        //   bit 2 = 0 → bit_value=0 → result=0x7F (positive) → ROM exits loop ✓
        //
        // For DVG BUSY (HALT=1):
        //   bit 2 = 1 → bit_value=1 → result=0x80 (negative) → ROM loops ✓
        //
        // DVG state: when halt=true, DVG is stopped/done (HALT signal LOW, bit 2 = 0)
        //            when running=true, DVG is processing (HALT signal HIGH, bit 2 = 1)
        if (dvg_state.running && !dvg_state.halt) {
            // DVG is actively RUNNING - HALT signal is HIGH (busy)
            // Set bit 2 = 1
            in0 |= 0x04;
        }
        // else: DVG is DONE (halted) - leave bit 2 = 0
        
        // Each address bit selects which bit to return in bit 7
        uint8_t bit_select = addr & 0x07;
        uint8_t bit_value = (in0 >> bit_select) & 0x01;
        
        // MAME logic: if bit set, return 0x80, else return ~0x80 (0x7F)
        uint8_t result = bit_value ? 0x80 : 0x7F;
        
        // DEBUG: Show IN0 reads, especially 0x2002 (DVG HALT) and 0x2007 (Self-Test)
        static int read_2002_count = 0;
        if (addr == 0x2002 && read_2002_count < 50) {
            Serial.printf("*** IN0 READ 0x2002 [%d]: DVG halt=%d running=%d → bit2=%d → RETURN 0x%02X (PC=%04X)\n",
                         read_2002_count++, dvg_state.halt, dvg_state.running, bit_value, result, cpu->GetPC());
        }
        
        if (addr == 0x2007 && read_count < 20) {
            Serial.printf("*** IN0[%d] READ 0x2007: in0=0x%02X, bit7=%d → RETURN 0x%02X (N=%d)\n",
                         read_count++, in0, bit_value, result, (result & 0x80) ? 1 : 0);
        }
        
        if (debug) {
            Serial.printf("*** IN0[%d] addr=0x%04X: in0=0x%02X, bit=%d, result=0x%02X\n", 
                         read_count, addr, in0, bit_value, result);
        }
        
        return result;
    }
    
    // IN1: 0x2400-0x2407 (player controls)
    if (addr >= 0x2400 && addr < 0x2408) {
        static int read_count = 0;
        if (read_count++ < 5) {
            Serial.printf("*** I/O read IN1 at 0x%04X\n", addr);
        }
        
        uint8_t in1 = 0x00;
        
        // EXPERIMENTAL: Auto-insert coin and press start
        // Simulate player inserting coin and pressing start button
        // This should trigger the game to begin and write to DVG
        static unsigned long game_start_time = 0;
        if (game_start_time == 0) {
            game_start_time = millis();
        }
        unsigned long game_runtime = millis() - game_start_time;
        
        // Insert coin after 2 seconds
        if (game_runtime >= 2000 && game_runtime < 4000) {
            in1 |= 0x01;  // Bit 0: Coin 1 PRESSED
        }
        
        // Press START after 4 seconds
        if (game_runtime >= 4000 && game_runtime < 6000) {
            in1 |= 0x08;  // Bit 3: Start 1 PRESSED
        }
        
        // Manual controls (after auto-start)
        if (buttons.coin)         in1 |= 0x01;  // Bit 0: Coin 1
        // Bit 1: Coin 2 (not implemented)
        // Bit 2: Coin 3 (not implemented)
        if (buttons.start)        in1 |= 0x08;  // Bit 3: Start 1
        // Bit 4: Start 2 (not implemented)
        if (buttons.thrust)       in1 |= 0x20;  // Bit 5: Thrust
        if (buttons.rotate_right) in1 |= 0x40;  // Bit 6: Right
        if (buttons.rotate_left)  in1 |= 0x80;  // Bit 7: Left
        
        uint8_t bit_select = addr & 0x07;
        uint8_t bit_value = (in1 >> bit_select) & 0x01;
        
        return bit_value ? 0x80 : 0x7F;
    }
    
    // DSW1: 0x2800-0x2803 (DIP switches)
    if (addr >= 0x2800 && addr < 0x2804) {
        static int read_count = 0;
        if (read_count++ < 5) {
            Serial.printf("*** I/O read DSW1 at 0x%04X\n", addr);
        }
        
        // Simplified DIP switch reading
        // Real hardware uses 74LS153 multiplexer controlled by offset
        uint8_t bit_select = addr & 0x03;
        uint8_t bit_pair = (dip_switches >> (bit_select * 2)) & 0x03;
        
        // Return bits in positions 0 and 1
        return 0xFC | bit_pair;
    }
    
    // ROM: 0x6800-0xFFFF (6KB ROM mirrored throughout this range)
#ifdef ASTEROID_ROMS_CONVERTED
    if (addr >= 0x6800) {
        // Debug: Monitor NMI handler access
        static int nmi_handler_access = 0;
        if (addr >= 0xF37B && addr < 0xF400 && nmi_handler_access < 5) {
            Serial.printf("*** NMI Handler READ [%d]: PC accessed 0x%04X\n", 
                         ++nmi_handler_access, addr);
        }
        
        // Special case: High vectors (0xF800-0xFFFF) always map to end of PROM2
        // This ensures reset/IRQ/NMI vectors are read correctly
        if (addr >= 0xF800) {
            uint16_t offset_in_last_2k = addr - 0xF800;  // 0x0000-0x07FF
            
            // Debug: Vector area reads - DISABLED for performance
            
            return asteroid_rom_prom2[offset_in_last_2k];
        }
        
        // The 6KB ROM (3x 2KB chips) is mirrored throughout 0x6800-0xF7FF
        uint16_t offset_from_base = addr - 0x6800;
        uint16_t rom_offset = offset_from_base % 0x1800;  // 0x1800 = 6KB
        
        // ROM layout in 6KB space:
        // 0x0000-0x07FF: PROM0 (035145-04e.ef2) - 0x6800-0x6FFF
        // 0x0800-0x0FFF: PROM1 (035144-04e.h2)  - 0x7000-0x77FF
        // 0x1000-0x17FF: PROM2 (035143-02.j2)   - 0x7800-0x7FFF
        if (rom_offset >= 0x1000) {
            // PROM2: offset 0x1000-0x17FF
            return asteroid_rom_prom2[rom_offset - 0x1000];
        } else if (rom_offset >= 0x0800) {
            // PROM1: offset 0x0800-0x0FFF
            return asteroid_rom_prom1[rom_offset - 0x0800];
        } else {
            // PROM0: offset 0x0000-0x07FF
            return asteroid_rom_prom0[rom_offset];
        }
    }
#endif
    
    return 0xFF;
}

void cpu6502_write_callback(uint16_t addr, uint8_t value) {
    // RAM: 0x0000-0x0FFF
    if (addr < 0x1000) {
        // DEBUG: Track Zero Page 0x5B (used by bit-shift loop)
        static int zp5b_write_count = 0;
        if (addr == 0x5B && zp5b_write_count < 30) {
            Serial.printf("*** ZP[0x5B] WRITE #%d: value=0x%02X (was 0x%02X), PC=0x%04X\n",
                         ++zp5b_write_count, value, ram[0x5B], cpu->GetPC());
        }
        
        // WORKAROUND: ZP[0x5B] Frame Throttle Counter
        // The ROM increments this every 4 frames in the NMI handler at 0x7B7B
        // and waits at 0x7B81 (BCS $7B81) if ZP[0x5B] >= 4
        // No code in ROM resets it, so we do it here to prevent infinite loop
        // This counter likely synchronizes with DVG frame completion or similar hardware timing
        if (addr == 0x5B && value >= 4) {
            Serial.printf("*** WORKAROUND: ZP[0x5B] reached %d, resetting to 0 (PC=0x%04X)\n", 
                         value, cpu->GetPC());
            value = 0;  // Reset to allow game loop to continue
        }
        
        ram[addr] = value;
        return;
    }
    
    // Vector RAM: 0x4000-0x47FF
    if (addr >= 0x4000 && addr < 0x4800) {
        static int write_count = 0;
        if (write_count++ < 100) {  // Show first 100 writes instead of 10
            Serial.printf("*** Vector RAM write [%d]: 0x%04X = 0x%02X\n", write_count, addr, value);
        }
        vector_ram[addr - 0x4000] = value;
        return;
    }
    
    // I/O Write Ports
    
    // Monitor all writes to 0x3000-0x3FFF range (ALL of them now!)
    static int write_3xxx_count = 0;
    if (addr >= 0x3000 && addr < 0x4000) {
        write_3xxx_count++;
        if (write_3xxx_count <= 50) {  // Show first 50
            Serial.printf("*** WRITE [%d]: addr=0x%04X, value=0x%02X, PC=0x%04X\n", 
                         write_3xxx_count, addr, value, cpu->GetPC());
        }
    }
    
    // DVG GO command: 0x3000
    if (addr == 0x3000) {
        static int go_count = 0;
        go_count++;
        
        extern int dvg_frame_count;
        dvg_frame_count++;  // Increment here where DVG actually runs!
        
        // ALWAYS show DVG GO with more context
        Serial.printf("\n*** DVG GO [%d] WRITE! ***\n", go_count);
        Serial.printf("    PC=0x%04X, value=0x%02X\n", cpu->GetPC(), value);
        
        // Show first 64 bytes of Vector RAM
        if (go_count <= 2) {
            Serial.printf("    VRAM DUMP (first 64 bytes):\n");
            for (int i = 0; i < 64; i += 8) {
                Serial.printf("    %04X: %02X %02X %02X %02X  %02X %02X %02X %02X\n", 
                             i,
                             vector_ram[i], vector_ram[i+1], vector_ram[i+2], vector_ram[i+3],
                             vector_ram[i+4], vector_ram[i+5], vector_ram[i+6], vector_ram[i+7]);
            }
        } else {
            Serial.printf("    VRAM[0..7]: %02X %02X %02X %02X  %02X %02X %02X %02X\n",
                         vector_ram[0], vector_ram[1], vector_ram[2], vector_ram[3],
                         vector_ram[4], vector_ram[5], vector_ram[6], vector_ram[7]);
        }
        
        // Start DVG processing from address in 'value'
        // In Asteroids, the value written is typically 0x00 (start from beginning)
        dvg_state.pc = (value & 0x0F) << 8;  // Only low 4 bits used as high address bits
        dvg_state.running = true;
        dvg_state.halt = false;
        dvg_state.stack_ptr = 0;
        dvg_state.state_latch = 0x00;  // PROM: Initial state
        dvg_state.op = 0;
        dvg_state.data = 0;
        dvg_state.dvx = 0;
        dvg_state.dvy = 0;
        
        // Clear previous vector buffer
        vector_buffer.count = 0;
        
        // Run the DVG state machine
        dvg_run_state_machine();
        
        return;
    }
    
    // Output latch: 0x3200 (coin counters, LEDs)
    if (addr == 0x3200) {
        static int latch_count = 0;
        if (latch_count++ < 5) {
            Serial.printf("*** Output latch write: 0x%02X\n", value);
        }
        // Bit 0: Right coin counter
        // Bit 1: Center coin counter  
        // Bit 2: Left coin counter
        // Bit 5-7: Player LEDs
        return;
    }
    
    // Watchdog reset: 0x3400
    if (addr == 0x3400) {
        // Watchdog is reset by any write to this address
        // We don't need to implement actual watchdog for emulation
        return;
    }
    
    // Explosion sound: 0x3600
    if (addr == 0x3600) {
        static int explode_count = 0;
        if (explode_count++ < 3) {
            Serial.printf("*** Explosion sound: 0x%02X\n", value);
        }
        // Bits 2-5: Volume (0-15)
        // Bits 6-7: Pitch select
        // TODO: Implement sound
        return;
    }
    
    // Thump sound: 0x3A00
    if (addr == 0x3A00) {
        static int thump_count = 0;
        if (thump_count++ < 3) {
            Serial.printf("*** Thump sound: 0x%02X\n", value);
        }
        // Bit 4: Enable
        // Bits 0-3: Frequency
        // TODO: Implement sound
        return;
    }
    
    // Audio latch (LS259): 0x3C00-0x3C07
    if (addr >= 0x3C00 && addr < 0x3C08) {
        static int audio_count = 0;
        if (audio_count++ < 5) {
            Serial.printf("*** Audio latch [%d]: bit %d = %d\n", 
                         audio_count, addr & 0x07, (value >> 7) & 0x01);
        }
        // Bit 0: Saucer sound enable
        // Bit 1: Saucer fire enable
        // Bit 2: Saucer select (big/small)
        // Bit 3: Thrust sound enable
        // Bit 4: Ship fire enable
        // Bit 5: Extra life sound enable
        // TODO: Implement sound
        return;
    }
    
    // Noise reset: 0x3E00
    if (addr == 0x3E00) {
        // Reset noise generator
        // TODO: Implement sound
        return;
    }
}

// ============================================================================
// INPUT HANDLING
// ============================================================================

void read_buttons() {
    buttons.rotate_left  = !digitalRead(BTN_LEFT_PIN);
    buttons.rotate_right = !digitalRead(BTN_RIGHT_PIN);
    buttons.thrust       = !digitalRead(BTN_UP_PIN);
    buttons.hyperspace   = !digitalRead(BTN_DOWN_PIN);
    buttons.fire         = !digitalRead(BTN_FIRE_PIN);
    buttons.start        = !digitalRead(BTN_START_PIN);
    buttons.coin         = !digitalRead(BTN_COIN_PIN);
}

// ============================================================================
// VECTOR DISPLAY
// ============================================================================

// ============================================================================
// VECTOR DISPLAY - DVG EMULATION
// ============================================================================

// Scale lookup table (approximated from MAME)
static const int scale_table[16] = {
    0, 1, 2, 3, 4, 5, 6, 8, 10, 12, 16, 20, 24, 32, 48, 64
};

void dvg_reset() {
    dvg_state.pc = 0;
    dvg_state.x = 512;  // Center of screen (1024x1024 coordinate system)
    dvg_state.y = 512;
    dvg_state.scale = 0;
    dvg_state.intensity = 7;
    dvg_state.stack_ptr = 0;
    dvg_state.halt = false;
}

void dvg_add_point(int16_t x, int16_t y, uint8_t intensity) {
    if (vector_buffer.count >= VECT_POINTS_PER_FRAME) return;
    
    // Convert from DVG coords (0-1023) to DAC coords (0-4095)
    // DVG uses signed offsets, we need to clamp and scale
    int16_t dac_x = (x * 4095) / 1023;
    int16_t dac_y = (y * 4095) / 1023;
    
    // Clamp to valid range
    if (dac_x < 0) dac_x = 0;
    if (dac_x > 4095) dac_x = 4095;
    if (dac_y < 0) dac_y = 0;
    if (dac_y > 4095) dac_y = 4095;
    
    // CSV logging of actual DAC output (first 5000 points)
    static int dac_log_count = 0;
    static bool dac_csv_header = false;
    
    if (dac_log_count < 5000) {
        if (!dac_csv_header) {
            Serial.println("\n=== DVG OUTPUT (10-bit coords, 4-bit intensity) ===");
            Serial.println("X,Y,Intensity");
            dac_csv_header = true;
        }
        
        Serial.printf("%d,%d,%d\n", x, y, intensity);
        dac_log_count++;
    }
    
    vector_buffer.points[vector_buffer.count][0] = dac_x;
    vector_buffer.points[vector_buffer.count][1] = dac_y;
    vector_buffer.intensity[vector_buffer.count] = (intensity * 255) / 15;
    vector_buffer.count++;
}

uint16_t dvg_read_word(uint16_t addr) {
    // DVG has its own address space:
    // 0x000-0x7FF: Vector RAM (CPU address 0x4000-0x47FF)
    // 0x800-0xFFF: Vector ROM (CPU address 0x5000-0x57FF)
    
    uint8_t lo, hi;
    
    if (addr < 0x800) {
        // Vector RAM
        if (addr >= 0x7FF) return 0;  // Safety check
        lo = vector_ram[addr];
        hi = vector_ram[addr + 1];
    } else {
        // Vector ROM - map DVG address to CPU address space
        uint16_t rom_addr = addr - 0x800;  // 0x800 -> 0x000 in ROM
        if (rom_addr >= 0x7FF) return 0;   // Safety check
        
        static bool first_rom_read = true;
        if (first_rom_read) {
            first_rom_read = false;
            Serial.printf("*** First Vector ROM read! DVG addr=0x%04X, ROM offset=0x%04X\n", addr, rom_addr);
        }
        
        lo = asteroid_rom_vector[rom_addr];
        hi = asteroid_rom_vector[rom_addr + 1];
    }
    
    // Words are stored little-endian
    return (hi << 8) | lo;
}

void dvg_execute() {
    dvg_reset();
    vector_buffer.count = 0;
    
    // Debug: Check if vector RAM has data
    static bool first_time = true;
    if (first_time) {
        first_time = false;
        Serial.println("Vector RAM first 32 bytes:");
        for (int i = 0; i < 32; i++) {
            Serial.printf("%02X ", vector_ram[i]);
            if ((i + 1) % 16 == 0) Serial.println();
        }
    }
    
    // DVG starts at address 0 in vector RAM
    int max_ops = 10000;  // Safety limit
    
    static int debug_op_count = 0;
    int ops_this_frame = 0;
    
    while (!dvg_state.halt && max_ops-- > 0) {
        uint16_t opcode = dvg_read_word(dvg_state.pc);
        uint16_t pc_before = dvg_state.pc;
        dvg_state.pc += 2;
        
        // Decode opcode (see MAME avgdvg.cpp for reference)
        uint8_t op = (opcode >> 12) & 0x0F;
        
        // Debug first 20 opcodes
        if (debug_op_count < 20) {
            Serial.printf("DVG[%d]: PC=0x%04X Op=0x%X Opcode=0x%04X\n", 
                debug_op_count, pc_before, op, opcode);
            debug_op_count++;
        }
        ops_this_frame++;
        
        switch (op) {
            case 0x0: // VCTR - Draw vector
            case 0x1:
            case 0x2:
            case 0x3:
            case 0x4:
            case 0x5:
            case 0x6:
            case 0x7: {
                // Extract fields
                int16_t dy = (opcode >> 0) & 0x03;  // 2 bits Y
                int16_t dx = (opcode >> 2) & 0x03;  // 2 bits X
                uint8_t brightness = (opcode >> 4) & 0x0F;  // 4 bits intensity
                uint8_t length = ((opcode >> 8) & 0x0F);    // 4 bits length
                
                // Sign extend 2-bit values to 16-bit
                if (dy & 0x02) dy |= 0xFFFC;
                if (dx & 0x02) dx |= 0xFFFC;
                
                // Apply scale
                int scale = scale_table[dvg_state.scale];
                dx = (dx * length * scale) >> 4;
                dy = (dy * length * scale) >> 4;
                
                // Draw line from current position to new position
                int16_t x0 = dvg_state.x;
                int16_t y0 = dvg_state.y;
                int16_t x1 = x0 + dx;
                int16_t y1 = y0 + dy;
                
                // Simple line drawing - add intermediate points
                int steps = max(abs(dx), abs(dy)) / 4;
                if (steps < 1) steps = 1;
                if (steps > 20) steps = 20;  // Limit points per line
                
                for (int i = 0; i <= steps; i++) {
                    int16_t x = x0 + (dx * i) / steps;
                    int16_t y = y0 + (dy * i) / steps;
                    dvg_add_point(x, y, brightness);
                }
                
                dvg_state.x = x1;
                dvg_state.y = y1;
                break;
            }
            
            case 0x8: // LABS - Load absolute position
            case 0x9: {
                uint16_t next = dvg_read_word(dvg_state.pc);
                dvg_state.pc += 2;
                
                dvg_state.y = (opcode & 0x03FF);
                dvg_state.x = (next & 0x03FF);
                break;
            }
            
            case 0xA: // JSRL - Jump to subroutine
                {
                    static int jsrl_count = 0;
                    uint16_t target = (opcode & 0x0FFF);
                    if (jsrl_count < 5) {
                        Serial.printf("*** JSRL[%d]: PC=0x%04X → 0x%04X (opcode=0x%04X)\n", 
                            jsrl_count++, pc_before, target, opcode);
                    }
                    if (dvg_state.stack_ptr < 4) {
                        dvg_state.stack[dvg_state.stack_ptr++] = dvg_state.pc;
                    }
                    dvg_state.pc = target;
                }
                break;
            
            case 0xB: // HALT
                {
                    static int halt_count = 0;
                    if (halt_count < 5) {
                        Serial.printf("*** HALT[%d]: PC=0x%04X opcode=0x%04X\n", 
                            halt_count++, pc_before, opcode);
                    }
                    dvg_state.halt = true;
                }
                break;
            
            case 0xC: // RTSL - Return from subroutine
                if (dvg_state.stack_ptr > 0) {
                    dvg_state.pc = dvg_state.stack[--dvg_state.stack_ptr];
                } else {
                    dvg_state.halt = true;
                }
                break;
            
            case 0xD: // JMPL - Jump
                // Extract 12-bit address - NO shift needed
                dvg_state.pc = (opcode & 0x0FFF);
                break;
            
            case 0xE: // SVEC - Short vector
            case 0xF: {
                int16_t dy = (opcode >> 0) & 0x07;  // 3 bits Y
                int16_t dx = (opcode >> 8) & 0x07;  // 3 bits X
                uint8_t brightness = (opcode >> 4) & 0x0F;
                
                // Sign extend 3-bit values
                if (dy & 0x04) dy |= 0xFFF8;
                if (dx & 0x04) dx |= 0xFFF8;
                
                // Apply scale
                int scale = scale_table[dvg_state.scale];
                dx = (dx * scale) >> 1;
                dy = (dy * scale) >> 1;
                
                int16_t x1 = dvg_state.x + dx;
                int16_t y1 = dvg_state.y + dy;
                
                dvg_add_point(dvg_state.x, dvg_state.y, brightness);
                dvg_add_point(x1, y1, brightness);
                
                dvg_state.x = x1;
                dvg_state.y = y1;
                break;
            }
        }
    }
}

void process_vector_list() {
    // Don't increment frame_count here - it's done in DVG GO handler!
    
    // Check if vector RAM has any non-zero data
    bool has_data = false;
    for (int i = 0; i < 32 && !has_data; i++) {
        if (vector_ram[i] != 0x00) has_data = true;
    }
    
    if (has_data) {
        // Execute DVG program from vector RAM
        dvg_execute();
    } else {
        // Fallback: Show test pattern until ROM fills vector RAM
        vector_buffer.count = 0;
        for (int i = 0; i < 100 && vector_buffer.count < VECT_POINTS_PER_FRAME; i++) {
            float angle = i * 2 * PI / 100.0;
            uint16_t x = 2048 + (int)(1024 * cos(angle));
            uint16_t y = 2048 + (int)(1024 * sin(angle));
            
            vector_buffer.points[vector_buffer.count][0] = x;
            vector_buffer.points[vector_buffer.count][1] = y;
            vector_buffer.intensity[vector_buffer.count] = 255;
            vector_buffer.count++;
        }
    }
}

void render_vectors() {
    // Render all buffered vector points to DAC
    for (int i = 0; i < vector_buffer.count; i++) {
        uint16_t x = vector_buffer.points[i][0];
        uint16_t y = vector_buffer.points[i][1];
        
        vector_dac.setXY(x, y);
        delayMicroseconds(VECT_DWELL_US);
    }
}

// ============================================================================
// EMULATION TASK (Core 0)
// ============================================================================

void emulation_task(void *parameter) {
    Serial.println("Emulation task started on core 0");
    
    // Remove this task from watchdog - it needs tight CPU timing
    disableCore0WDT();
    
    Serial.println("\n=== FRAME-BASED EMULATION (MAME Style) ===");
    Serial.println("Running CPU at maximum speed");
    Serial.println("NMI triggered every ~300 instructions (tunable)\n");
    
    // Frame-based emulation: Run as fast as possible
    // Trigger NMI based on instruction count, not real time
    // This matches how MAME works - it runs "full speed" and syncs to display
    
    const uint32_t INSTRUCTIONS_PER_NMI = 300;  // Tunable parameter
    uint32_t instruction_count = 0;
    
    bool nmi_active = false;
    uint32_t nmi_release_count = 0;
    
    uint64_t total_instructions = 0;
    uint32_t nmi_count = 0;
    unsigned long last_status_time = micros();
    unsigned long start_time = micros();
    
    Serial.println("*** Frame-based emulation started ***\n");
    
    while (true) {
        // Run CPU - single instruction for maximum control
        uint64_t cycles = 0;
        cpu->Run(1, cycles);
        instruction_count++;
        total_instructions++;
        
        // Check if we reached main game code (0x6800-0x6FFF)
        uint16_t pc = cpu->GetPC();
        static bool reached_game_code = false;
        if (!reached_game_code && pc >= 0x6800 && pc < 0x7000) {
            reached_game_code = true;
            Serial.printf("\n*** REACHED MAIN GAME CODE! PC=0x%04X ***\n", pc);
            Serial.printf("    After %llu instructions, %u NMIs\n\n", 
                         total_instructions, nmi_count);
        }
        
        // Trigger NMI every INSTRUCTIONS_PER_NMI instructions
        if (!nmi_active && instruction_count >= INSTRUCTIONS_PER_NMI) {
            cpu->NMI(false);  // Pull NMI line LOW (trigger)
            nmi_active = true;
            nmi_release_count = 0;
            instruction_count = 0;
            nmi_count++;
        }
        
        // Release NMI after a few instructions (simulate edge trigger)
        if (nmi_active) {
            nmi_release_count++;
            if (nmi_release_count >= 3) {
                cpu->NMI(true);  // Pull NMI line HIGH (release)
                nmi_active = false;
            }
        }
        
        // Status report every 2 seconds (real time)
        unsigned long now = micros();
        if (now - last_status_time >= 2000000) {
            unsigned long elapsed_ms = (now - start_time) / 1000;
            float instructions_per_sec = total_instructions / (elapsed_ms / 1000.0);
            
            Serial.printf("*** Status: %llu instructions in %lu ms (%.0f inst/sec), %u NMIs, PC=0x%04X\n",
                         total_instructions, elapsed_ms, instructions_per_sec, nmi_count, cpu->GetPC());
            
            last_status_time = now;
        }
    }
}

// ============================================================================
// SETUP & MAIN LOOP (Core 1)
// ============================================================================

void setup() {
    Serial.begin(SERIAL_BAUD);
    delay(100);  // Wait for Serial to stabilize
    
    Serial.println("\n\n=================================");
    Serial.println("  Asteroidino - Asteroids on ESP32");
    Serial.println("=================================\n");
    
    Serial.printf("CPU Freq: %d MHz\n", getCpuFrequencyMhz());
    Serial.printf("Free heap: %d bytes\n", ESP.getFreeHeap());
    Serial.printf("Chip: ESP32 rev%d\n", ESP.getChipRevision());
    
    // Initialize GPIO buttons
    pinMode(BTN_LEFT_PIN, INPUT_PULLUP);
    pinMode(BTN_RIGHT_PIN, INPUT_PULLUP);
    pinMode(BTN_UP_PIN, INPUT_PULLUP);
    pinMode(BTN_DOWN_PIN, INPUT_PULLUP);
    pinMode(BTN_FIRE_PIN, INPUT_PULLUP);
    pinMode(BTN_START_PIN, INPUT_PULLUP);
    pinMode(BTN_COIN_PIN, INPUT_PULLUP);
    
    // Initialize Vector DAC
    vector_dac.begin();
    
    // Run test pattern
#ifdef VECT_TEST_PATTERN
    vector_dac.test_pattern();
    delay(2000);
#endif
    
    // Initialize CPU with callbacks
    cpu = new mos6502(cpu6502_read_callback, cpu6502_write_callback);
    
    // Initialize interrupt lines (NMI is edge-triggered HIGH->LOW)
    cpu->NMI(true);  // Set NMI line HIGH (inactive)
    cpu->IRQ(true);  // Set IRQ line HIGH (inactive)
    
    // Initialize RAM with pseudo-random values (mimics power-on state)
    // Real hardware has unpredictable RAM contents at boot
    // ROM code must initialize any values it needs
    for (int i = 0; i < MEM_SIZE_RAM; i++) {
        ram[i] = (i * 7 + 123) & 0xFF;  // Pseudo-random pattern
    }
    Serial.printf("*** RAM initialized: ZP[0x5B]=0x%02X, ZP[0x5C]=0x%02X, ZP[0x5D]=0x%02X\n",
                  ram[0x5B], ram[0x5C], ram[0x5D]);
    
    // Initialize DVG state
    memset(&dvg_state, 0, sizeof(dvg_state));
    dvg_state.halt = true;  // Start in halted state
    dvg_state.x = 512;      // Center of screen
    dvg_state.y = 512;
    
    // Force complete RAM clear before reset
    Serial.println("*** Clearing all RAM...");
    memset(ram, 0x00, 0x400);  // Clear all 1KB of RAM
    
    Serial.println("*** Calling CPU Reset()...");
    cpu->Reset();
    
    Serial.printf("*** CPU after Reset(): PC = 0x%04X\n", cpu->GetPC());
    
    // Check initial RAM state
    Serial.printf("*** Initial ZP[0x5B] = 0x%02X (should be 0x00 after reset)\n", ram[0x5B]);
    Serial.printf("*** Initial RAM[0x72] = 0x%02X (wait counter at 0x7ACD loop)\n", ram[0x72]);
    Serial.printf("*** Initial RAM[0x7A] = 0x%02X (used by 0x7A95 button code)\n", ram[0x7A]);
    Serial.printf("*** Initial RAM[0x7C] = 0x%02X (used by 0x7A95 button code, X=2)\n", ram[0x7C]);
    
    // WORKAROUND: NMI handler at 0x7B71 waits for RAM[0x01FF] and RAM[0x01D0] to be 0x00
    // These are frame synchronization flags
    // The reset handler clears all RAM, so this should already be 0, but set explicitly to be sure
    ram[0x01FF] = 0x00;
    ram[0x01D0] = 0x00;
    Serial.printf("*** Frame sync flags: RAM[0x01FF]=0x%02X, RAM[0x01D0]=0x%02X\n", 
                  ram[0x01FF], ram[0x01D0]);
    Serial.printf("*** Reading byte at PC: 0x%02X\n", cpu6502_read_callback(cpu->GetPC()));
    Serial.printf("*** Reading byte at PC+1: 0x%02X\n", cpu6502_read_callback(cpu->GetPC() + 1));
    Serial.printf("*** Reading byte at PC+2: 0x%02X\n", cpu6502_read_callback(cpu->GetPC() + 2));
    
    // Check if ROMs are present
#ifndef ASTEROID_ROMS_CONVERTED
    Serial.println("\n*** WARNING: ROMs not converted! ***");
    Serial.println("Please run: cd romconv && python3 romconv.py");
    Serial.println("Continuing with test pattern only...\n");
#else
    Serial.println("ROMs loaded successfully");
    Serial.println("\n*** NMI configured as per MAME: 250 Hz, only when IN0 bit 7 = 0 ***\n");
#endif
    
    // Start emulation on Core 0
    xTaskCreatePinnedToCore(
        emulation_task,
        "emulation",
        8192,  // Stack size
        NULL,
        2,     // Priority
        &emulation_task_handle,
        0      // Core 0
    );
    
    Serial.println("\nSetup complete. Running...\n");
}

void loop() {
    // Main loop runs on Core 1
    // Handles display refresh and input
    
    static unsigned long last_frame = 0;
    unsigned long now = micros();
    
    // 60 Hz frame rate
    if (now - last_frame >= 16667) {
        last_frame = now;
        
        // Read input
        read_buttons();
        
        // Render vectors
        render_vectors();
        
        // Debug output - CSV format for analysis
        static unsigned long last_debug = 0;
        static int frame_number = 0;
        static bool csv_header_printed = false;
        
        // CSV OUTPUT: First 100 frames
        if (frame_number < 100) {
            // Print CSV header once
            if (!csv_header_printed) {
                Serial.println("\n=== ASTEROIDS VECTOR DATA CSV ===");
                Serial.println("Frame,VectorCount,Index,X,Y,Z");
                csv_header_printed = true;
            }
            
            // Output all vectors in this frame
            for (int i = 0; i < vector_buffer.count; i++) {
                Serial.printf("%d,%d,%d,%d,%d,%d\n",
                    frame_number,
                    vector_buffer.count,
                    i,
                    vector_buffer.points[i][0],
                    vector_buffer.points[i][1],
                    vector_buffer.intensity[i]);
            }
            frame_number++;
        }
        
        // OLD DEBUG CODE (kept for reference)
        /*
        if (now - last_debug >= 1000000) {  // Every second = ~60 frames
            last_debug = now;
            
            // Print CSV header once
            if (!csv_header_printed) {
                Serial.println("\n=== ASTEROIDS VECTOR DATA CSV ===");
                Serial.println("Frame,VectorCount,PC,Index,X,Y,Intensity");
                csv_header_printed = true;
            }
            
            // Output current frame info
            uint16_t pc = cpu->GetPC();
            int vec_count = vector_buffer.count;
            
            // Print first 5 frames in detail, then summary
            if (frame_number < 5) {
                // Detailed CSV output
                for (int i = 0; i < vec_count && i < VECT_POINTS_PER_FRAME; i++) {
                    Serial.printf("%d,%d,0x%04X,%d,%d,%d,%d\n",
                                 frame_number,
                                 vec_count,
                                 pc,
                                 i,
                                 vector_buffer.points[i][0],
                                 vector_buffer.points[i][1],
                                 vector_buffer.intensity[i]);
                }
            } else if (frame_number == 5) {
                Serial.println("=== CSV DETAILED OUTPUT END ===");
                Serial.println("(Continuing with summary output...)\n");
            }
            
            // Summary output after first 5 frames
            if (frame_number >= 5) {
                Serial.printf("Frame %d: PC=0x%04X, Vectors=%d, VRAM[0..3]=0x%02X%02X%02X%02X\n",
                             frame_number, pc, vec_count,
                             vector_ram[0], vector_ram[1], vector_ram[2], vector_ram[3]);
                
                // Show first and last vector of frame
                if (vec_count > 0) {
                    Serial.printf("  First: (%d,%d,I=%d), Last: (%d,%d,I=%d)\n",
                                 vector_buffer.points[0][0],
                                 vector_buffer.points[0][1],
                                 vector_buffer.intensity[0],
                                 vector_buffer.points[vec_count-1][0],
                                 vector_buffer.points[vec_count-1][1],
                                 vector_buffer.intensity[vec_count-1]);
                }
            }
            
            frame_number++;
        }
        */
    }
    
    yield();  // Let other tasks run
}
