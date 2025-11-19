/*
 * test_vector_logger.cpp - Unit Tests für Vector Logger
 * 
 * Verwendung:
 * - Uncomment #define RUN_VECTOR_LOGGER_TEST in main.cpp
 * - Upload und Serial Monitor öffnen
 * - Logs werden in SPIFFS geschrieben: /vector_test.csv, /vector_test.bin, /vector_test.txt
 */

#include <Arduino.h>
#include "vector_logger.h"

void test_vector_logger_csv() {
    Serial.println("\n=== Test: CSV Logger ===");
    
    VectorLogger logger;
    logger.begin("/vector_test.csv", LOG_CSV);
    
    // Simuliere 3 Frames mit verschiedenen Mustern
    for (uint32_t frame = 0; frame < 3; frame++) {
        logger.beginFrame(frame);
        logger.logComment("Frame start");
        
        // Linie von (0,0) nach (4095, 4095)
        logger.logBlank();  // Beam off
        logger.logXYZ(0, 0, 0);
        logger.logUnblank();  // Beam on
        for (int i = 0; i <= 10; i++) {
            uint16_t pos = i * 409;  // 0, 409, 818, ..., 4095
            logger.logXYZ(pos, pos, 255);  // Full intensity
        }
        logger.logBlank();
        
        logger.endFrame();
    }
    
    logger.end();
    Serial.println("CSV test complete. Check /vector_test.csv");
}

void test_vector_logger_binary() {
    Serial.println("\n=== Test: Binary Logger ===");
    
    VectorLogger logger;
    logger.begin("/vector_test.bin", LOG_BINARY);
    
    // Kreis mit 360 Punkten
    logger.beginFrame(0);
    for (int angle = 0; angle < 360; angle++) {
        float rad = angle * PI / 180.0;
        uint16_t x = 2048 + (int)(2000 * cos(rad));
        uint16_t y = 2048 + (int)(2000 * sin(rad));
        uint8_t z = 128 + 127 * sin(rad * 2);  // Intensity modulation
        logger.logXYZ(x, y, z);
    }
    logger.endFrame();
    
    logger.end();
    Serial.println("Binary test complete. Check /vector_test.bin");
}

void test_vector_logger_text() {
    Serial.println("\n=== Test: Text Logger ===");
    
    VectorLogger logger;
    logger.begin("/vector_test.txt", LOG_TEXT);
    
    logger.beginFrame(0);
    logger.logComment("Drawing square");
    
    logger.logBlank();
    logger.logXYZ(1024, 1024, 0);
    logger.logUnblank();
    logger.logXYZ(3072, 1024, 255);
    logger.logXYZ(3072, 3072, 255);
    logger.logXYZ(1024, 3072, 255);
    logger.logXYZ(1024, 1024, 255);
    logger.logBlank();
    
    logger.endFrame();
    logger.end();
    
    Serial.println("Text test complete. Check /vector_test.txt");
}

void list_spiffs_files() {
    Serial.println("\n=== SPIFFS Files ===");
    File root = SPIFFS.open("/");
    File file = root.openNextFile();
    size_t total = 0;
    
    while (file) {
        Serial.printf("  %s (%u bytes)\n", file.name(), file.size());
        total += file.size();
        file = root.openNextFile();
    }
    
    Serial.printf("Total: %u bytes\n", total);
    Serial.printf("SPIFFS: %u / %u bytes used\n", 
                  SPIFFS.usedBytes(), SPIFFS.totalBytes());
}

void read_and_print_file(const char* filename) {
    Serial.printf("\n=== Content of %s ===\n", filename);
    File file = SPIFFS.open(filename, FILE_READ);
    if (!file) {
        Serial.println("Failed to open file!");
        return;
    }
    
    // Nur erste 1000 bytes ausgeben (für große Dateien)
    size_t max_bytes = min((size_t)1000, file.size());
    for (size_t i = 0; i < max_bytes; i++) {
        Serial.write(file.read());
    }
    
    if (file.size() > max_bytes) {
        Serial.printf("\n... (%u more bytes)\n", file.size() - max_bytes);
    }
    
    file.close();
    Serial.println("\n===================");
}

void run_all_vector_logger_tests() {
    Serial.println("\n╔═══════════════════════════════════╗");
    Serial.println("║  Vector Logger Test Suite         ║");
    Serial.println("╚═══════════════════════════════════╝");
    
    // SPIFFS initialisieren
    if (!SPIFFS.begin(true)) {
        Serial.println("ERROR: SPIFFS mount failed!");
        return;
    }
    
    // Alte Test-Dateien löschen
    SPIFFS.remove("/vector_test.csv");
    SPIFFS.remove("/vector_test.bin");
    SPIFFS.remove("/vector_test.txt");
    
    // Tests ausführen
    test_vector_logger_csv();
    delay(100);
    
    test_vector_logger_binary();
    delay(100);
    
    test_vector_logger_text();
    delay(100);
    
    // Ergebnisse anzeigen
    list_spiffs_files();
    
    // CSV und Text Dateien ausgeben
    read_and_print_file("/vector_test.csv");
    read_and_print_file("/vector_test.txt");
    
    Serial.println("\n✓ All tests complete!");
    Serial.println("Binary file /vector_test.bin can be analyzed with Python:");
    Serial.println("  import struct");
    Serial.println("  data = open('/vector_test.bin', 'rb').read()[5:]");
    Serial.println("  points = [struct.unpack('<HHH', data[i:i+6]) for i in range(0, len(data), 6)]");
}
