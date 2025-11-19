# ✅ PlatformIO Setup erfolgreich!

## Was funktioniert jetzt?

```bash
$ pio run -e esp32dev
========================= [SUCCESS] Took 4.07 seconds =========================

RAM:   [=         ]  13.8% (used 45216 bytes from 327680 bytes)
Flash: [==        ]  23.6% (used 309465 bytes from 1310720 bytes)
```

## Projektstruktur

```
asteroidino/
├── platformio.ini              # PlatformIO Config
├── src/
│   ├── main.cpp               # Haupt-Sketch (früher asteroidino.ino)
│   └── config.h               # Hardware-Definitionen
└── lib/
    ├── cpu6502/               # 6502 CPU Emulator
    │   ├── cpu6502.h          # Original mos6502.h
    │   ├── cpu6502.cpp        # 65 KB Implementation
    │   └── library.properties
    └── vector_dac/            # MCP4922 DAC Treiber
        ├── vector_dac.h
        ├── vector_dac.cpp
        └── library.properties
```

## PlatformIO Befehle

### Build
```bash
pio run                    # Baue Standard-Environment
pio run -e esp32dev       # Explizites Environment
pio run -e esp32dev_release  # Release-Build (O3)
pio run -e esp32dev_debug    # Debug-Build (Og)
```

### Upload (mit ESP32 verbunden)
```bash
pio run -t upload
pio run -t upload -e esp32dev
```

### Serial Monitor
```bash
pio device monitor
# oder kombiniert:
pio run -t upload && pio device monitor
```

### Clean
```bash
pio run -t clean
```

### Größe prüfen
```bash
pio run -t size
```

## Build-Ergebnis

| Resource | Usage | Details |
|----------|-------|---------|
| **RAM** | 13.8% | 45.216 / 327.680 bytes |
| **Flash** | 23.6% | 309.465 / 1.310.720 bytes |
| **Build-Zeit** | ~4 sec | Intel Core |

## Libraries

- **cpu6502**: MOS 6502 CPU Emulator (65 KB, 257 Opcodes)
- **vector_dac**: MCP4922 SPI DAC Driver (2 KB)
- **SPI**: Built-in Arduino SPI Library

## vs. Arduino IDE

| Feature | Arduino IDE | PlatformIO |
|---------|-------------|------------|
| Build-System | Arduino Builder | CMake-basiert |
| Dependencies | Manuel | Automatisch |
| Environments | Ein Build | Multi-Environment |
| Debugging | ❌ | ✅ |
| Cl-Interface | ❌ | ✅ |
| Git-Integration | Basic | Advanced |

## Nächste Schritte

### 1. ESP32 anschließen
```bash
# Zeige verfügbare Ports
pio device list
```

### 2. Upload
```bash
pio run -t upload
```

### 3. Monitor
```bash
pio device monitor
# Sollte zeigen:
# =================================
#  Asteroidino - Asteroids on ESP32
# =================================
# CPU initialized, PC = 0x....
```

### 4. ROMs hinzufügen (optional)
```bash
cd ../romconv
python3 romconv.py
# Fügt ASTEROID_ROMS_CONVERTED define hinzu
```

## Troubleshooting

### Port nicht gefunden
```bash
pio device list
pio run -t upload --upload-port /dev/cu.usbserial-*
```

### Permission denied (macOS/Linux)
```bash
sudo chmod 666 /dev/cu.usbserial-*
```

### Neuinstall Dependencies
```bash
pio lib install
```

## VS Code Integration

PlatformIO erstellt automatisch:
- `.vscode/c_cpp_properties.json` - IntelliSense
- `.vscode/extensions.json` - Empfohlene Extensions

Empfohlene Extension:
```
platformio.platformio-ide
```

## Vergleich: Vorher vs. Nachher

| | Arduino (.ino) | PlatformIO (.ini) |
|---|---|---|
| Dateien | `asteroidino.ino` | `src/main.cpp` |
| CPU | `cpu6502.h/cpp` (im Haupt-Ordner) | `lib/cpu6502/` |
| Config | `config.h` (global) | `src/config.h` |
| Build | Arduino Builder | CMake + PlatformIO |
| Upload | Arduino IDE GUI | CLI: `pio run -t upload` |

## Erfolg! 🎉

Das Projekt ist jetzt bereit für:
- ✅ Kompilierung ohne Fehler
- ✅ Upload zum ESP32 (wenn angeschlossen)
- ✅ Serial Monitoring
- ✅ Multi-Environment Builds
- ✅ VS Code Integration mit IntelliSense

Teste jetzt: `pio run -t upload` (mit angeschlossenem ESP32)
