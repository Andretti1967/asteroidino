/*
 * vector_dac.cpp - SPI DAC Implementation
 * Supports: MCP4922 (Dual) and MCP4821 (Single)
 */

#include "../../src/config.h"  // MUST be first for VECT_USE_MCP4821
#include "vector_dac.h"

void VectorDAC::begin() {
    spi = &SPI;
    spi_settings = SPISettings(VECT_SPI_SPEED, MSBFIRST, SPI_MODE0);
    
#if VECT_USE_MCP4821
    // 3x MCP4821 (X, Y, Z)
    cs_x_pin = VECT_SPI_CS_X;
    cs_y_pin = VECT_SPI_CS_Y;
    cs_z_pin = VECT_SPI_CS_Z;
    
    pinMode(cs_x_pin, OUTPUT);
    pinMode(cs_y_pin, OUTPUT);
    pinMode(cs_z_pin, OUTPUT);
    digitalWrite(cs_x_pin, HIGH);
    digitalWrite(cs_y_pin, HIGH);
    digitalWrite(cs_z_pin, HIGH);
    
    spi->begin(VECT_SPI_CLK, -1, VECT_SPI_MOSI, cs_x_pin);
    
    Serial.println("Vector DAC initialized: 3x MCP4821 (X, Y, Z analog)");
#else
    // 1x MCP4922 (Dual DAC) + digital Z
    cs_pin = VECT_SPI_CS;
    blank_pin = VECT_BLANK_PIN;
    
    pinMode(cs_pin, OUTPUT);
    pinMode(blank_pin, OUTPUT);
    digitalWrite(cs_pin, HIGH);
    digitalWrite(blank_pin, LOW);  // Start blanked
    
    spi->begin(VECT_SPI_CLK, -1, VECT_SPI_MOSI, cs_pin);
    
    Serial.println("Vector DAC initialized: 1x MCP4922 (X, Y analog, Z digital)");
#endif
    
    // Initialize DAC to center position, beam off
    setXY(2048, 2048);
    setIntensity(0);  // Beam off
}


#if VECT_USE_MCP4821
// MCP4821: Single DAC (3 chips for X, Y, Z)
void VectorDAC::write_dac_single(uint8_t cs_pin, uint16_t value) {
    // MCP4821: 16-bit command
    // Bit 15: /SHDN (0=shutdown, 1=active)
    // Bit 14: unused
    // Bit 13: GA (1=1x, 0=2x gain)
    // Bit 12: /BUF (1=unbuffered, 0=buffered)
    // Bit 11-0: Data (12-bit value)
    
    uint16_t cmd = DAC_CMD_SINGLE | (value & 0x0FFF);
    
    spi->beginTransaction(spi_settings);
    digitalWrite(cs_pin, LOW);
    spi->write16(cmd);
    digitalWrite(cs_pin, HIGH);
    spi->endTransaction();
}

void VectorDAC::setXY(uint16_t x, uint16_t y) {
    x &= 0x0FFF;  // Clamp to 12-bit
    y &= 0x0FFF;
    
    write_dac_single(cs_x_pin, x);  // X-Achse (MCP4821 #1)
    delayMicroseconds(1);
    write_dac_single(cs_y_pin, y);  // Y-Achse (MCP4821 #2)
}

void VectorDAC::setIntensity(uint8_t intensity) {
    // Z-Achse: 8-bit -> 12-bit conversion (0-255 -> 0-4095)
    // Scale: intensity * 16 (with slight adjustment)
    uint16_t z_value = (intensity > 0) ? ((uint16_t)intensity << 4) | (intensity >> 4) : 0;
    write_dac_single(cs_z_pin, z_value);  // Z-Achse (MCP4821 #3)
}

#else
// MCP4922: Dual DAC (1 chip, 2 channels)
void VectorDAC::write_dac(uint8_t channel, uint16_t value) {
    // MCP4922: 16-bit command
    // Bit 15: Channel (0=A, 1=B)
    // Bit 14: Buffered (0=unbuffered)
    // Bit 13: Gain (1=1x, 0=2x)
    // Bit 12: Shutdown (1=active, 0=shutdown)
    // Bit 11-0: Data (12-bit value)
    
    uint16_t cmd = (channel ? DAC_CMD_B : DAC_CMD_A) | (value & 0x0FFF);
    
    spi->beginTransaction(spi_settings);
    digitalWrite(VECT_SPI_CS, LOW);
    spi->write16(cmd);
    digitalWrite(VECT_SPI_CS, HIGH);
    spi->endTransaction();
}

void VectorDAC::setXY(uint16_t x, uint16_t y) {
    // Clamp to 12-bit range
    x &= 0x0FFF;
    y &= 0x0FFF;
    
    write_dac(0, x);  // Channel A = X
    delayMicroseconds(1);  // Short settling time
    write_dac(1, y);  // Channel B = Y
}
#endif  // VECT_USE_MCP4821

void VectorDAC::blank() {
    // Beam off: Z = 0
    setIntensity(0);
}

void VectorDAC::unblank() {
    // Beam full on: Z = 255
    setIntensity(255);
}

#if !VECT_USE_MCP4821
// Only needed for MCP4922 (digital Z fallback)
void VectorDAC::setIntensity(uint8_t intensity) {
    // Digital blanking: 0 = off, >0 = on
    if (intensity > 0) {
        digitalWrite(blank_pin, HIGH);
    } else {
        digitalWrite(blank_pin, LOW);
    }
}
#endif

void VectorDAC::setXYZ(uint16_t x, uint16_t y, uint8_t intensity) {
    setXY(x, y);
    setIntensity(intensity);
}

void VectorDAC::test_pattern() {
    Serial.println("Vector DAC test pattern (3x MCP4821: X, Y, Z)...");
    
    // Test 1: Square with varying intensity
    Serial.println("  - Square with intensity ramp");
    for (uint8_t intensity = 0; intensity <= 255; intensity += 32) {
        setIntensity(0);  // Blank for move
        setXY(1024, 1024);
        delay(5);
        
        setIntensity(intensity);  // Set brightness
        setXY(3072, 1024);  delay(20);
        setXY(3072, 3072);  delay(20);
        setXY(1024, 3072);  delay(20);
        setXY(1024, 1024);  delay(20);
    }
    
    setIntensity(0);  // Blank
    delay(100);
    
    // Test 2: Circle with sinusoidal intensity modulation
    Serial.println("  - Circle with intensity modulation");
    for (int angle = 0; angle < 360; angle += 5) {
        float rad = angle * PI / 180.0;
        uint16_t x = 2048 + (int)(1024 * cos(rad));
        uint16_t y = 2048 + (int)(1024 * sin(rad));
        
        // Intensity: 0-255 sinusoidal (bright at 0°, dim at 180°, bright at 360°)
        uint8_t intensity = 128 + 127 * sin(rad);
        
        setXY(x, y);
        setIntensity(intensity);
        delay(10);
    }
    
    setIntensity(0);  // Blank at end
    delay(100);
    
    // Test 3: Brightness levels (8 steps)
    Serial.println("  - 8 brightness levels");
    for (int level = 0; level < 8; level++) {
        uint8_t intensity = level * 32;  // 0, 32, 64, 96, 128, 160, 192, 224
        setIntensity(0);
        setXY(512 + level * 512, 2048);
        delay(5);
        setIntensity(intensity);
        
        // Draw short vertical line
        for (int y = 1548; y <= 2548; y += 50) {
            setXY(512 + level * 512, y);
            delay(5);
        }
    }
    
    setIntensity(0);
    Serial.println("Test pattern complete");
}
