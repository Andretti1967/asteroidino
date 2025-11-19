# Vector Logger - Anleitung

## Übersicht

Der Vector Logger gibt X/Y/Z-Werte **direkt über Serial** aus - kein SPIFFS nötig!

## Setup

### 1. In `config.h` aktivieren:

```cpp
#define ENABLE_VECTOR_LOGGER
#define VECTOR_LOG_MODE LOG_CSV  // oder LOG_BINARY, LOG_TEXT
```

### 2. Im Code verwenden (z.B. in `main.cpp`):

```cpp
#include "vector_logger.h"

void setup() {
    Serial.begin(115200);
    
    #ifdef ENABLE_VECTOR_LOGGER
    vectorLog.begin(VECTOR_LOG_MODE);
    #endif
}

void loop() {
    static uint32_t frame = 0;
    
    #ifdef ENABLE_VECTOR_LOGGER
    vectorLog.beginFrame(frame++);
    #endif
    
    // Dein Vector-Code hier:
    vectorDAC.setXYZ(x, y, intensity);
    
    #ifdef ENABLE_VECTOR_LOGGER
    vectorLog.logXYZ(x, y, intensity);
    #endif
    
    #ifdef ENABLE_VECTOR_LOGGER
    vectorLog.endFrame();
    #endif
}
```

## Daten empfangen

### Methode 1: PlatformIO Serial Monitor (einfach)

```bash
# Terminal 1: Öffne Serial Monitor
pio device monitor > vectors.csv

# Nach ein paar Sekunden: Ctrl+C
# Datei vectors.csv ist fertig!
```

### Methode 2: Capture Script (sauber)

```bash
# macOS:
./tools/capture_serial_log.sh /dev/cu.usbserial-0001 vectors.csv

# Linux:
./tools/capture_serial_log.sh /dev/ttyUSB0 vectors.csv

# Windows (Git Bash):
./tools/capture_serial_log.sh COM3 vectors.csv
```

### Methode 3: screen (manuell)

```bash
# Starte screen
screen /dev/cu.usbserial-0001 115200

# Logging aktivieren: Ctrl+A, dann H
# Es wird "screenlog.0" erstellt

# Beenden: Ctrl+A, dann K

# Umbenennen
mv screenlog.0 vectors.csv
```

## Daten analysieren

```bash
# Statistik anzeigen
python3 tools/analyze_vector_log.py vectors.csv --stats

# Plot erstellen (benötigt matplotlib)
python3 tools/analyze_vector_log.py vectors.csv --plot

# Plot als Bild speichern
python3 tools/analyze_vector_log.py vectors.csv --plot --output plot.png

# Binary zu CSV konvertieren
python3 tools/analyze_vector_log.py vectors.bin --export-csv --output export.csv
```

## Log-Formate

### CSV (menschenlesbar, ~50 bytes/Punkt)
```
frame,x,y,z,comment
0,2048,2048,255,
0,2100,2100,255,
0,,,0,BLANK
```

### Binary (kompakt, 6 bytes/Punkt)
```
VEC1<mode><x1><x2><y1><y2><z1><z2>...
```
Header: "VEC1" + 1 byte mode
Daten: X(2), Y(2), Z(2) little-endian

### Text (debug, ~30 bytes/Punkt)
```
=== Vector Logger Start ===
Timestamp: 1234 ms
===========================
F0: (2048, 2048,  255)
F0: (2100, 2100,  255)
F0: BLANK
```

## Tipps

1. **Binary für lange Sessions**: Spart 80% Speicher
2. **CSV für Quick-Debug**: Direkt in Excel/Numbers öffnen
3. **Text für manuelles Debuggen**: Gut lesbar im Terminal

## Performance

- CSV: ~20 KB/Frame (400 Punkte)
- Binary: ~2.5 KB/Frame (400 Punkte)
- Baudrate 115200: Max ~10 KB/s = 2 Frames/s bei Binary

**Für mehr Frames/Sekunde: Baudrate erhöhen**

```cpp
// In platformio.ini:
monitor_speed = 921600  // 8x schneller!
```
