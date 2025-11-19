/*
 * vector_logger.cpp - Vector Output Logger Implementation
 * Ausgabe direkt über Serial.write()
 */

#include "vector_logger.h"

VectorLogger vectorLog;  // Globale Instanz

VectorLogger::VectorLogger() 
    : logging_active(false)
    , mode(LOG_DISABLED)
    , point_count(0)
    , frame_count(0)
    , current_frame(0)
    , bytes_written(0)
    , min_x(4095), max_x(0)
    , min_y(4095), max_y(0)
    , min_z(4095), max_z(0)
{
}

VectorLogger::~VectorLogger() {
    end();
}

void VectorLogger::writeSerial(const char* str) {
    Serial.print(str);
    bytes_written += strlen(str);
}

void VectorLogger::writeSerial(uint8_t byte) {
    Serial.write(byte);
    bytes_written++;
}

void VectorLogger::begin(LogMode log_mode) {
    mode = log_mode;
    
    if (mode == LOG_DISABLED) {
        return;
    }
    
    logging_active = true;
    resetStats();
    
    // Header über Serial schreiben
    switch (mode) {
        case LOG_CSV:
            writeSerial("frame,x,y,z,comment\n");
            break;
            
        case LOG_TEXT:
            writeSerial("=== Vector Logger Start ===\n");
            char buffer[64];
            snprintf(buffer, sizeof(buffer), "Timestamp: %lu ms\n", millis());
            writeSerial(buffer);
            writeSerial("===========================\n");
            break;
            
        case LOG_BINARY:
            // Binary header: Magic "VEC1" + mode byte
            writeSerial('V');
            writeSerial('E');
            writeSerial('C');
            writeSerial('1');
            writeSerial((uint8_t)mode);
            break;
            
        default:
            break;
    }
    
    Serial.flush();  // Stelle sicher, dass Header gesendet wird
}

void VectorLogger::end() {
    if (!logging_active) return;
    
    // Footer über Serial schreiben
    char buffer[128];
    
    switch (mode) {
        case LOG_TEXT:
            writeSerial("=== Vector Logger End ===\n");
            snprintf(buffer, sizeof(buffer), "Total Points: %u\n", point_count);
            writeSerial(buffer);
            snprintf(buffer, sizeof(buffer), "Total Frames: %u\n", frame_count);
            writeSerial(buffer);
            break;
            
        case LOG_CSV:
            snprintf(buffer, sizeof(buffer), "# Total Points: %u\n", point_count);
            writeSerial(buffer);
            snprintf(buffer, sizeof(buffer), "# Total Frames: %u\n", frame_count);
            writeSerial(buffer);
            break;
            
        default:
            break;
    }
    
    Serial.flush();  // Stelle sicher, dass alles gesendet wird
    logging_active = false;
}

void VectorLogger::logXYZ(uint16_t x, uint16_t y, uint16_t z) {
    if (!logging_active) return;
    
    // Auf 12-Bit clampen
    x &= 0x0FFF;
    y &= 0x0FFF;
    z &= 0x0FFF;
    
    updateStats(x, y, z);
    
    char buffer[64];
    
    switch (mode) {
        case LOG_CSV:
            snprintf(buffer, sizeof(buffer), "%lu,%u,%u,%u,\n", current_frame, x, y, z);
            writeSerial(buffer);
            break;
            
        case LOG_BINARY:
            // 6 bytes: X(2) + Y(2) + Z(2), Little Endian
            writeSerial((uint8_t)(x & 0xFF));
            writeSerial((uint8_t)(x >> 8));
            writeSerial((uint8_t)(y & 0xFF));
            writeSerial((uint8_t)(y >> 8));
            writeSerial((uint8_t)(z & 0xFF));
            writeSerial((uint8_t)(z >> 8));
            break;
            
        case LOG_TEXT:
            snprintf(buffer, sizeof(buffer), "F%lu: (%4u, %4u, %4u)\n", current_frame, x, y, z);
            writeSerial(buffer);
            break;
            
        default:
            break;
    }
    
    point_count++;
}

void VectorLogger::logXYZ(uint16_t x, uint16_t y, uint8_t intensity) {
    // 8-bit -> 12-bit conversion (same as vector_dac.cpp)
    uint16_t z = (intensity > 0) ? ((uint16_t)intensity << 4) | (intensity >> 4) : 0;
    logXYZ(x, y, z);
}

void VectorLogger::logBlank() {
    if (!logging_active) return;
    
    char buffer[64];
    
    switch (mode) {
        case LOG_CSV:
            snprintf(buffer, sizeof(buffer), "%lu,,,0,BLANK\n", current_frame);
            writeSerial(buffer);
            break;
            
        case LOG_TEXT:
            snprintf(buffer, sizeof(buffer), "F%lu: BLANK\n", current_frame);
            writeSerial(buffer);
            break;
            
        case LOG_BINARY:
            // Special marker: X=0xFFFF, Y=0xFFFF, Z=0
            writeSerial((uint8_t)0xFF);
            writeSerial((uint8_t)0xFF);
            writeSerial((uint8_t)0xFF);
            writeSerial((uint8_t)0xFF);
            writeSerial((uint8_t)0x00);
            writeSerial((uint8_t)0x00);
            break;
            
        default:
            break;
    }
}

void VectorLogger::logUnblank() {
    if (!logging_active) return;
    
    char buffer[64];
    
    switch (mode) {
        case LOG_CSV:
            snprintf(buffer, sizeof(buffer), "%lu,,,4095,UNBLANK\n", current_frame);
            writeSerial(buffer);
            break;
            
        case LOG_TEXT:
            snprintf(buffer, sizeof(buffer), "F%lu: UNBLANK\n", current_frame);
            writeSerial(buffer);
            break;
            
        case LOG_BINARY:
            // Special marker: X=0xFFFF, Y=0xFFFF, Z=0xFFFF
            writeSerial((uint8_t)0xFF);
            writeSerial((uint8_t)0xFF);
            writeSerial((uint8_t)0xFF);
            writeSerial((uint8_t)0xFF);
            writeSerial((uint8_t)0xFF);
            writeSerial((uint8_t)0xFF);
            break;
            
        default:
            break;
    }
}

void VectorLogger::logComment(const char* comment) {
    if (!logging_active) return;
    if (mode != LOG_CSV && mode != LOG_TEXT) return;
    
    char buffer[128];
    
    switch (mode) {
        case LOG_CSV:
            snprintf(buffer, sizeof(buffer), "%lu,,,%s\n", current_frame, comment);
            writeSerial(buffer);
            break;
            
        case LOG_TEXT:
            snprintf(buffer, sizeof(buffer), "F%lu: # %s\n", current_frame, comment);
            writeSerial(buffer);
            break;
            
        default:
            break;
    }
}

void VectorLogger::beginFrame(uint32_t frame_number) {
    current_frame = frame_number;
}

void VectorLogger::endFrame() {
    frame_count++;
    
    // Periodisches Flush alle 10 Frames
    if (logging_active && (frame_count % 10 == 0)) {
        Serial.flush();
    }
}

void VectorLogger::updateStats(uint16_t x, uint16_t y, uint16_t z) {
    if (x < min_x) min_x = x;
    if (x > max_x) max_x = x;
    if (y < min_y) min_y = y;
    if (y > max_y) max_y = y;
    if (z < min_z) min_z = z;
    if (z > max_z) max_z = z;
}

void VectorLogger::printStats() {
    Serial.println("=== Vector Logger Statistics ===");
    Serial.printf("Points logged: %u\n", point_count);
    Serial.printf("Frames logged: %u\n", frame_count);
    if (frame_count > 0) {
        Serial.printf("Avg points/frame: %.1f\n", (float)point_count / frame_count);
    }
    Serial.printf("X range: %u - %u\n", min_x, max_x);
    Serial.printf("Y range: %u - %u\n", min_y, max_y);
    Serial.printf("Z range: %u - %u\n", min_z, max_z);
    Serial.printf("Bytes written: %u\n", bytes_written);
    Serial.println("================================");
}

void VectorLogger::resetStats() {
    point_count = 0;
    frame_count = 0;
    current_frame = 0;
    bytes_written = 0;
    min_x = 4095; max_x = 0;
    min_y = 4095; max_y = 0;
    min_z = 4095; max_z = 0;
}
