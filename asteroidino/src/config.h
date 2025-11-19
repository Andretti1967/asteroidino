/*
 * config.h - Hardware-Konfiguration für Asteroidino
 */

#ifndef _CONFIG_H_
#define _CONFIG_H_

// ============================================================================
// DISPLAY KONFIGURATION - SPI DAC für Vector-Ausgabe
// ============================================================================

// Hardware-Option: MCP4821 oder MCP4922
// MCP4821: 2x Single-Channel DAC (ein CS pro Achse)
// MCP4922: 1x Dual-Channel DAC (ein CS für beide Achsen)
#define VECT_USE_MCP4821    1     // 1 = 2x MCP4821, 0 = 1x MCP4922

#if VECT_USE_MCP4821
  // 3x MCP4821 (Single 12-bit DAC für X, Y, Z)
  #define VECT_SPI_CS_X    5      // Chip Select X-Achse
  #define VECT_SPI_CS_Y    16     // Chip Select Y-Achse
  #define VECT_SPI_CS_Z    17     // Chip Select Z-Achse (Intensität)
  #define VECT_SPI_CLK     18     // SPI Clock (SCK) - shared
  #define VECT_SPI_MOSI    23     // SPI MOSI - shared
#else
  // 1x MCP4922 (Dual 12-bit DAC) + Digital Z
  #define VECT_SPI_CS      5      // Chip Select (beide Kanäle)
  #define VECT_SPI_CLK     18     // SPI Clock (SCK)
  #define VECT_SPI_MOSI    23     // SPI MOSI
  #define VECT_BLANK_PIN   17     // Z-Achse: Beam Blanking (digital)
#endif

#define VECT_SPI_SPEED   20000000  // 20 MHz SPI clock

// Vector display timing
#define VECT_POINTS_PER_FRAME  2048   // Max Punkte pro Frame
#define VECT_REFRESH_HZ        60     // Frame rate
#define VECT_DWELL_US          2      // Verweildauer pro Punkt (µs)

// ============================================================================
// AUDIO KONFIGURATION - I2S DAC
// ============================================================================

#define AUDIO_I2S_BCK    26   // I2S Bit Clock
#define AUDIO_I2S_WS     25   // I2S Word Select (LRCK)
#define AUDIO_I2S_DATA   22   // I2S Data Out
#define AUDIO_SAMPLE_RATE 22050  // Sample rate (Hz)
#define AUDIO_BUFFER_SIZE 64     // Samples pro Buffer

// ============================================================================
// INPUT KONFIGURATION - GPIO Buttons
// ============================================================================

// Asteroids benötigt 5 Game-Buttons + 2 System-Buttons
#define BTN_LEFT_PIN     32   // Rotate Left
#define BTN_RIGHT_PIN    33   // Rotate Right  
#define BTN_UP_PIN       34   // Thrust (Schub)
#define BTN_DOWN_PIN     35   // Hyperspace (Hyperraum)
#define BTN_FIRE_PIN     15   // Fire (Feuer)
#define BTN_START_PIN    14   // Start (1 Player)
#define BTN_COIN_PIN     27   // Coin (Münze)

// Button debounce time (ms)
#define BTN_DEBOUNCE_MS  20

// ============================================================================
// EMULATION KONFIGURATION
// ============================================================================

// 6502 CPU @ 1.5 MHz, 60 Hz refresh = 25000 cycles/frame
// Aber wir brauchen auch Zeit für Display + Audio, also konservativ:
#define CPU_CYCLES_PER_FRAME  20000

// Memory map (vereinfacht)
#define MEM_SIZE_RAM     0x1000   // 4 KB RAM (0x0000-0x0FFF)
#define MEM_SIZE_VECTOR  0x800    // 2 KB Vector RAM (0x4000-0x47FF)
#define MEM_SIZE_ROM     0x4000   // 16 KB ROM (0x6000-0x9FFF actual, mapped)

// ============================================================================
// DEBUG / ENTWICKLUNG
// ============================================================================

// Uncomment für Debug-Ausgaben über Serial
// #define DEBUG_SERIAL
// #define DEBUG_VECTOR     // Vector-Dekodierung loggen
// #define DEBUG_CPU        // 6502 Instructions loggen (LANGSAM!)
// #define DEBUG_AUDIO      // Audio-Buffer-Status

// Vector Logger aktivieren (loggt X/Y/Z in Datei)
// #define ENABLE_VECTOR_LOGGER
// #define VECTOR_LOG_FILE "/vectors.csv"  // oder .bin, .txt
// #define VECTOR_LOG_MODE LOG_CSV         // LOG_CSV, LOG_BINARY, LOG_TEXT

// Test-Modi
// #define RUN_VECTOR_LOGGER_TEST  // Führt vector_logger Tests aus

// Serial baud rate
#define SERIAL_BAUD      115200

// ============================================================================
// HARDWARE-VARIANTEN
// ============================================================================

// Für Test ohne echten DAC (sendet Debug-Info statt SPI)
// #define VECT_SIMULATION_MODE

// Oszilloskop-Test-Pattern (Kreis, Quadrat, etc.)
// #define VECT_TEST_PATTERN

#endif // _CONFIG_H_
