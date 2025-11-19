# Build-Anleitung für Asteroidino

## Schnellstart

1. **ROMs vorbereiten**
   ```bash
   # Lege die Asteroids ROM-Dateien in roms/ ab
   # Dann:
   cd romconv
   python3 romconv.py
   cd ..
   ```

2. **Arduino IDE öffnen**
   - Öffne `asteroidino/asteroidino.ino`
   - Board auswählen: "ESP32 Dev Module"
   - Port auswählen
   - Upload drücken

3. **Hardware verbinden**
   - Siehe `README.md` für Pin-Belegung
   - MCP4922 DAC an SPI (CS=5, CLK=18, MOSI=23)
   - Buttons an GPIOs (mit Pullups)

## Detaillierte Schritte

### 1. Arduino IDE Setup

#### Installation
- Lade Arduino IDE herunter: https://www.arduino.cc/en/software
- Installiere Version 1.8.19 oder 2.x

#### ESP32 Board Support
1. Öffne: Datei → Einstellungen
2. Zusätzliche Boardverwalter-URLs:
   ```
   https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
   ```
3. Werkzeuge → Board → Boardverwalter
4. Suche "esp32"
5. Installiere "ESP32 by Espressif Systems" Version **2.0.9**
   (NICHT 2.0.10+ wegen I2S-Bug!)

#### Board-Einstellungen
- **Board**: ESP32 Dev Module
- **Upload Speed**: 921600
- **CPU Frequency**: 240 MHz (WiFi/BT)
- **Flash Frequency**: 80 MHz
- **Flash Mode**: QIO
- **Flash Size**: 4 MB (32Mb)
- **Partition Scheme**: Default 4MB with spiffs
- **Core Debug Level**: None (oder "Info" für Debugging)
- **PSRAM**: Disabled (oder Enabled wenn vorhanden)

### 2. ROM-Konvertierung

#### Voraussetzungen
- Python 3.6 oder höher
- Asteroids ROM-Dateien (siehe `roms/README.md`)

#### Konvertierung durchführen
```bash
cd romconv
python3 romconv.py
```

**Erwartete Ausgabe:**
```
Asteroidino ROM Converter
==================================================
✓ Created asteroid_rom_prog1.h (2048 bytes)
✓ Created asteroid_rom_prog2.h (2048 bytes)
✓ Created asteroid_rom_prog3.h (2048 bytes)
✓ Created asteroid_rom_vector.h (2048 bytes)
✓ Created asteroid_rom_color.h (256 bytes)
✓ Created asteroid_roms.h (combined header)

==================================================
✓ Successfully converted all 5 ROM files
```

#### Troubleshooting
- **"ERROR: ROM file not found"**: Lege ROM-Dateien in `roms/` ab
- **"WARNING: file is X bytes, expected Y"**: Falsche ROM-Version? Prüfe Dateinamen

### 3. Kompilierung

#### In Arduino IDE
1. Öffne `asteroidino/asteroidino.ino`
2. Sketch → Verify/Compile (Ctrl+R)
3. Warte auf erfolgreiche Kompilierung

**Erwartete Ausgaben:**
```
Der Sketch verwendet 823456 Bytes (62%) des Programmspeicherplatzes
Globale Variablen verwenden 45678 Bytes (13%) des dynamischen Speichers
```

#### Häufige Fehler

**"asteroid_roms.h: No such file"**
→ ROMs noch nicht konvertiert! Führe `romconv.py` aus.

**"cpu6502.h: No such file"**
→ Falsches Verzeichnis geöffnet. Öffne `asteroidino.ino`, nicht einzelne .h-Dateien.

**"SPI.h: No such file"**
→ ESP32 Board Support nicht installiert.

### 4. Upload zum ESP32

1. ESP32 per USB verbinden
2. Werkzeuge → Port → (wähle den richtigen COM/ttyUSB Port)
3. Sketch → Upload (Ctrl+U)

**Während des Uploads:**
- Einige ESP32-Boards benötigen das Drücken des "BOOT"-Buttons
- TX/RX LEDs sollten blinken
- Fortschrittsbalken in der IDE

**Nach erfolgreichem Upload:**
- Serial Monitor öffnen (Werkzeuge → Serial Monitor)
- Baudrate auf 115200 setzen
- Du solltest sehen:
  ```
  =================================
    Asteroidino - Asteroids on ESP32
  =================================
  
  ESP-IDF: ...
  CPU Freq: 240 MHz
  Free heap: ... bytes
  Vector DAC initialized
  CPU initialized, PC = 0x...
  ```

### 5. Test ohne Hardware (Simulation)

Falls du noch keine DAC-Hardware hast, aktiviere den Simulationsmodus:

In `asteroidino/config.h`:
```c
#define VECT_SIMULATION_MODE
#define VECT_TEST_PATTERN
```

Dann kannst du im Serial Monitor die Debug-Ausgaben sehen statt realer SPI-Signale.

### 6. Hardware-Verbindung

#### Minimaler Test-Aufbau
Nur um zu sehen, ob der Code läuft:
- ESP32
- USB-Kabel
- Buttons (optional, mit internen Pullups)

#### Vollständiger Aufbau
- ESP32-WROOM Dev Board
- MCP4922 DAC (oder MCP4822)
  - VDD → 3.3V
  - VSS → GND
  - CS → GPIO 5
  - SCK → GPIO 18
  - SDI (MOSI) → GPIO 23
  - LDAC → GND (für sofortiges Update)
  - SHDN → 3.3V (immer an)
  - VOUT A → X-Eingang (Oszilloskop oder Vector-Display)
  - VOUT B → Y-Eingang
- Oszilloskop oder Vector-Monitor (XY-Modus)
- Buttons:
  - Eine Seite → GND
  - Andere Seite → GPIO (siehe config.h)
  - Keine externen Pullups nötig (ESP32 hat interne)

#### Oszilloskop-Setup
1. Channel 1 → X (DAC A)
2. Channel 2 → Y (DAC B)
3. Modus → XY
4. Trigger → Off oder Auto
5. Du solltest ein Kreis- oder Test-Pattern sehen

### 7. Debugging

#### Serial Monitor
Wichtigste Debug-Infos:
```
CPU cycles: 12000, Vectors: 100
```
Zeigt CPU-Aktivität und Anzahl der gerenderten Vektorpunkte.

#### Common Issues

**Keine Ausgabe im Serial Monitor**
- Baudrate falsch? Muss 115200 sein
- Board nicht korrekt gebootet? Reset-Button drücken

**"ROMs not converted!"**
- Führe `romconv/romconv.py` aus

**Vector DAC reagiert nicht**
- Prüfe SPI-Verkabelung (vor allem CS, CLK, MOSI)
- Prüfe Spannungsversorgung (3.3V!)
- Aktiviere `VECT_SIMULATION_MODE` zum Testen

**Absturz/Reboot-Loop**
- Zu wenig Heap-Memory? Check Serial Monitor
- Stack overflow? Erhöhe Stack-Size in `xTaskCreate...`

## Weiterführende Schritte

### Performance-Optimierung
- Erhöhe `CPU_CYCLES_PER_FRAME` wenn zu langsam
- Reduziere `VECT_POINTS_PER_FRAME` wenn Flackern auftritt
- Experimentiere mit `VECT_DWELL_US`

### Vollständige 6502-Emulation
Die aktuelle `cpu6502.cpp` ist ein Proof-of-Concept mit nur ~10 Opcodes.
Für ein voll funktionierendes Asteroids benötigst du alle 151 Opcodes.

Empfehlung: Verwende eine bewährte Bibliothek wie:
- **fake6502** (Public Domain, sehr kompakt)
- **lib6502** (MIT-Lizenz)

### DVG-Emulation
Die aktuelle `process_vector_list()` ist ein Platzhalter.
Echte Asteroids-Vektoren werden vom Digital Vector Generator (DVG)
aus kompakten Befehlen in `vector_ram[]` generiert.

Siehe MAME source `src/mame/video/avgdvg.cpp` für Referenz.

## Support

Bei Problemen:
1. Check Serial Monitor Output
2. Aktiviere Debug-Flags in `config.h`
3. Vergleiche mit Galagino (ähnliche Architektur)
4. MAME source als Referenz (für DVG, 6502, Memory-Map)
