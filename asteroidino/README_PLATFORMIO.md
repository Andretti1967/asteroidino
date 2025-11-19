# Asteroidino - PlatformIO Project

## Quick Start

### 1. Build
```bash
pio run
```

### 2. Upload (mit ESP32 verbunden)
```bash
pio run --target upload
```

### 3. Serial Monitor
```bash
pio device monitor
```

### 4. Clean
```bash
pio run --target clean
```

## Build-Targets

### Standard (optimiert)
```bash
pio run -e esp32dev
```

### Release (maximale Optimierung)
```bash
pio run -e esp32dev_release
```

### Debug (mit Debugging-Symbolen)
```bash
pio run -e esp32dev_debug
```

## Projektstruktur

```
asteroidino/
├── platformio.ini          # PlatformIO Konfiguration
├── src/
│   ├── main.cpp           # Haupt-Sketch
│   └── config.h           # Hardware-Konfiguration
├── lib/
│   ├── cpu6502/           # 6502 CPU Emulator
│   │   ├── cpu6502.h
│   │   ├── cpu6502.cpp
│   │   └── library.properties
│   └── vector_dac/        # MCP4922 DAC Treiber
│       ├── vector_dac.h
│       ├── vector_dac.cpp
│       └── library.properties
└── .pio/                  # Build-Artefakte (ignoriert)
```

## Hardware-Konfiguration

Alle Pin-Definitionen in `src/config.h`:
- SPI für MCP4922 DAC (Vector Display)
- I2S für PCM5102A (Audio)
- GPIO für 7 Buttons

## Tipps

### IntelliSense in VS Code
PlatformIO erstellt automatisch `.vscode/c_cpp_properties.json`

### Kompilier-Ausgabe anzeigen
```bash
pio run -v
```

### Bestimmte Datei kompilieren
```bash
pio run --target lib/cpu6502/cpu6502.cpp
```

### Flash-Größe prüfen
```bash
pio run --target size
```

## Troubleshooting

### Fehler: "Port not found"
```bash
# Zeige verfügbare Ports
pio device list

# Manuell Port setzen
pio run --target upload --upload-port /dev/cu.usbserial-*
```

### Fehler: "Permission denied"
```bash
# macOS/Linux: Berechtigung für Serial Port
sudo chmod 666 /dev/ttyUSB0  # oder /dev/cu.usbserial-*
```

### Upload schlägt fehl
```bash
# Halte BOOT-Button beim Upload gedrückt
# oder: Auto-Reset deaktivieren
```

## Dependencies

- Platform: espressif32
- Framework: Arduino
- Board: ESP32 Dev Module
- Libraries: SPI (built-in)

## Build-Flags

- `-O2`: Optimierung Level 2
- `-DCORE_DEBUG_LEVEL=3`: Debug-Output
- `-mfix-esp32-psram-cache-issue`: PSRAM-Fix

## Next Steps

1. ROMs hinzufügen: `cd ../romconv && python3 romconv.py`
2. Hardware anschließen (siehe ../README.md)
3. Kompilieren: `pio run`
4. Upload: `pio run -t upload`
5. Monitor: `pio device monitor`
