/*
 * vector_dac.h - SPI DAC Treiber für Vektor-Ausgabe
 * 
 * Unterstützt:
 * - MCP4922 (Dual 12-bit DAC) - Channel A = X, Channel B = Y
 * - MCP4821 (Single 12-bit DAC) - 3 Chips für X, Y, Z
 */

#ifndef VECTOR_DAC_H
#define VECTOR_DAC_H

#include <Arduino.h>
#include <SPI.h>

// MCP4922 Commands (Dual DAC)
#define DAC_CMD_A     0x3000  // Channel A, unbuffered, 1x gain, active
#define DAC_CMD_B     0xB000  // Channel B, unbuffered, 1x gain, active

// MCP4821 Commands (Single DAC) 
#define DAC_CMD_SINGLE 0x3000  // Unbuffered, 1x gain, active

#define DAC_SHUTDOWN  0x0000  // Shutdown

// Forward-declare config - must be included in .cpp before this header
#ifndef VECT_USE_MCP4821
#error "config.h must be included before vector_dac.h"
#endif

class VectorDAC {
public:
    void begin();
    void setXY(uint16_t x, uint16_t y);  // 12-bit values (0-4095)
    void setXYZ(uint16_t x, uint16_t y, uint8_t intensity);  // X, Y, Z
    void blank();     // Turn off beam (Z=0)
    void unblank();   // Turn on beam (Z=1)
    void setIntensity(uint8_t intensity);  // 0=off, 1-15=brightness
    void test_pattern();  // Generate test pattern for oscilloscope
    
private:
    SPIClass *spi;
    SPISettings spi_settings;
    
#if VECT_USE_MCP4821
    // 3x MCP4821: separate CS pins for X, Y, Z
    uint8_t cs_x_pin;
    uint8_t cs_y_pin;
    uint8_t cs_z_pin;
    void write_dac_single(uint8_t cs_pin, uint16_t value);
#else
    // 1x MCP4922: one CS, two channels + digital Z pin
    uint8_t cs_pin;
    uint8_t blank_pin;
    void write_dac(uint8_t channel, uint16_t value);
#endif
};

#endif // VECTOR_DAC_H
