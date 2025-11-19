/*
 * vector_logger.h - Vector Output Logger für Test/Debug
 * 
 * Loggt X/Y/Z-Werte direkt über Serial in verschiedene Formate:
 * - CSV für Analyse in Excel/Python
 * - Raw Binary für Oszilloskop-Replay
 * - Text-Format für menschenlesbare Debug-Ausgabe
 * 
 * Output geht direkt an Serial, kein SPIFFS benötigt!
 */

#ifndef VECTOR_LOGGER_H
#define VECTOR_LOGGER_H

#include <Arduino.h>

// Log-Modi
enum LogMode {
    LOG_DISABLED = 0,
    LOG_CSV,         // X,Y,Z CSV format über Serial
    LOG_BINARY,      // Raw binary (6 bytes pro Punkt: X:2, Y:2, Z:2)
    LOG_TEXT         // Human-readable text
};

class VectorLogger {
public:
    VectorLogger();
    ~VectorLogger();
    
    // Initialisierung - kein Filename mehr nötig!
    void begin(LogMode mode = LOG_CSV);
    void end();
    
    // Logging - geht direkt an Serial
    void logXYZ(uint16_t x, uint16_t y, uint16_t z);
    void logXYZ(uint16_t x, uint16_t y, uint8_t intensity);  // 8-bit Z -> 12-bit
    void logBlank();     // Beam off event
    void logUnblank();   // Beam on event
    void logComment(const char* comment);  // Text comment (nur bei LOG_TEXT/CSV)
    
    // Frame-Tracking
    void beginFrame(uint32_t frame_number);
    void endFrame();
    
    // Status
    bool isLogging() const { return logging_active; }
    size_t getPointCount() const { return point_count; }
    size_t getBytesWritten() const { return bytes_written; }
    
    // Statistik
    void printStats();
    void resetStats();
    
private:
    LogMode mode;
    bool logging_active;
    
    // Statistik
    size_t point_count;
    size_t frame_count;
    uint32_t current_frame;
    size_t bytes_written;
    
    // Min/Max für Analyse
    uint16_t min_x, max_x;
    uint16_t min_y, max_y;
    uint16_t min_z, max_z;
    
    // Helper
    void updateStats(uint16_t x, uint16_t y, uint16_t z);
    void writeSerial(const char* str);
    void writeSerial(uint8_t byte);
};

// Globale Instanz (optional, kann auch lokal erstellt werden)
extern VectorLogger vectorLog;

#endif // VECTOR_LOGGER_H
