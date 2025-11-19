//============================================================================
// cpu6502.h - MOS 6502 CPU Emulator for Asteroidino
// Based on: mos6502 by Gianluca Ghettini (MIT License)
//           https://github.com/gianlucag/mos6502
// Adapted for: ESP32-WROOM + Arduino environment
//============================================================================

#ifndef CPU6502_H
#define CPU6502_H

#include <stdint.h>
#include <stdbool.h>

// Status register flags
#define NEGATIVE  0x80
#define OVERFLOW  0x40
#define CONSTANT  0x20
#define BREAK     0x10
#define DECIMAL   0x08
#define INTERRUPT 0x04
#define ZERO      0x02
#define CARRY     0x01

// Callback types for memory bus access
typedef uint8_t (*BusRead)(uint16_t address);
typedef void (*BusWrite)(uint16_t address, uint8_t value);
typedef void (*ClockCycle)(void* cpu);

class mos6502
{
private:
    // Register reset values
    uint8_t reset_A;
    uint8_t reset_X;
    uint8_t reset_Y;
    uint8_t reset_sp;
    uint8_t reset_status;

    // CPU registers
    uint8_t A;      // Accumulator
    uint8_t X;      // X-index
    uint8_t Y;      // Y-index
    uint8_t sp;     // Stack pointer
    uint16_t pc;    // Program counter
    uint8_t status; // Status register

    // Instruction execution function pointers
    typedef void (mos6502::*CodeExec)(uint16_t);
    typedef uint16_t (mos6502::*AddrExec)();

    struct Instr
    {
        AddrExec addr;
        const char* saddr;
        CodeExec code;
        const char* scode;
        uint8_t cycles;
        bool penalty;
    };

    static Instr InstrTable[256];

    void Exec(Instr i);

    bool illegalOpcode;
    bool crossed;   // Page boundary crossed
    bool branched;  // Branch taken

    // Interrupt handling
    bool irq_line;
    bool nmi_request;
    bool nmi_inhibit;
    bool nmi_line;

    // Bus callbacks
    BusRead Read;
    BusWrite Write;
    ClockCycle Cycle;

    // Addressing modes
    uint16_t Addr_ACC(); uint16_t Addr_IMM(); uint16_t Addr_ABS();
    uint16_t Addr_ZER(); uint16_t Addr_ZEX(); uint16_t Addr_ZEY();
    uint16_t Addr_ABX(); uint16_t Addr_ABY(); uint16_t Addr_IMP();
    uint16_t Addr_REL(); uint16_t Addr_INX(); uint16_t Addr_INY();
    uint16_t Addr_ABI();

    // Opcodes (grouped as per datasheet)
    void Op_ADC(uint16_t src); void Op_AND(uint16_t src);
    void Op_ASL(uint16_t src); void Op_ASL_ACC(uint16_t src);
    void Op_BCC(uint16_t src); void Op_BCS(uint16_t src);
    void Op_BEQ(uint16_t src); void Op_BIT(uint16_t src);
    void Op_BMI(uint16_t src); void Op_BNE(uint16_t src);
    void Op_BPL(uint16_t src); void Op_BRK(uint16_t src);
    void Op_BVC(uint16_t src); void Op_BVS(uint16_t src);
    void Op_CLC(uint16_t src); void Op_CLD(uint16_t src);
    void Op_CLI(uint16_t src); void Op_CLV(uint16_t src);
    void Op_CMP(uint16_t src); void Op_CPX(uint16_t src);
    void Op_CPY(uint16_t src); void Op_DEC(uint16_t src);
    void Op_DEX(uint16_t src); void Op_DEY(uint16_t src);
    void Op_EOR(uint16_t src); void Op_INC(uint16_t src);
    void Op_INX(uint16_t src); void Op_INY(uint16_t src);
    void Op_JMP(uint16_t src); void Op_JSR(uint16_t src);
    void Op_LDA(uint16_t src); void Op_LDX(uint16_t src);
    void Op_LDY(uint16_t src); void Op_LSR(uint16_t src);
    void Op_LSR_ACC(uint16_t src); void Op_NOP(uint16_t src);
    void Op_ORA(uint16_t src); void Op_PHA(uint16_t src);
    void Op_PHP(uint16_t src); void Op_PLA(uint16_t src);
    void Op_PLP(uint16_t src); void Op_ROL(uint16_t src);
    void Op_ROL_ACC(uint16_t src); void Op_ROR(uint16_t src);
    void Op_ROR_ACC(uint16_t src); void Op_RTI(uint16_t src);
    void Op_RTS(uint16_t src); void Op_SBC(uint16_t src);
    void Op_SEC(uint16_t src); void Op_SED(uint16_t src);
    void Op_SEI(uint16_t src); void Op_STA(uint16_t src);
    void Op_STX(uint16_t src); void Op_STY(uint16_t src);
    void Op_TAX(uint16_t src); void Op_TAY(uint16_t src);
    void Op_TSX(uint16_t src); void Op_TXA(uint16_t src);
    void Op_TXS(uint16_t src); void Op_TYA(uint16_t src);
    void Op_ILLEGAL(uint16_t src);

    // Stack operations
    void StackPush(uint8_t byte);
    uint8_t StackPop();

    // Interrupt service routines
    void Svc_IRQ();
    void Svc_NMI();
    bool CheckInterrupts();

public:
    // Constructor
    mos6502(BusRead r, BusWrite w, ClockCycle c = nullptr);

    // Execution methods
    void Run(int32_t cyclesRemaining, uint64_t& cycleCount, bool countCycles = true);
    void Step();  // Execute one instruction

    // Register access
    uint16_t GetPC();
    uint8_t GetA();
    uint8_t GetX();
    uint8_t GetY();
    uint8_t GetS();
    uint8_t GetP();

    // Interrupt control
    void Reset();
    void IRQ(bool line);
    void NMI(bool line);

    // Reset value setters (for initialization)
    void SetResetA(uint8_t value);
    void SetResetX(uint8_t value);
    void SetResetY(uint8_t value);
    void SetResetS(uint8_t value);
    void SetResetP(uint8_t value);
};

#endif // CPU6502_H
