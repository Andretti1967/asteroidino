# 🎮 Asteroidino - Quick Start Guide

## Was hast du bekommen?

Ein vollständiges ESP32-Projekt für Asteroids-Emulation mit:

✅ **6502 CPU** - Alle 151 Opcodes (basierend auf mos6502 Library, MIT License)  
✅ **Vector Display** - SPI DAC (MCP4922) für analoge X/Y-Ausgabe  
✅ **Dual-Core** - Core 0: CPU-Emulation, Core 1: Display & Input  
✅ **I2S Audio** - PCM5102A DAC für Sound  
✅ **ROM Converter** - Python-Tool für Asteroids ROMs  

---

## 🚀 Schnellstart (3 Schritte)

### 1. CPU-Emulator herunterladen

```bash
cd /Users/andres/mame/asteroidino/asteroidino
./setup_cpu.sh
```

Das lädt automatisch **mos6502.cpp** herunter und passt es für ESP32 an.

### 2. ROMs konvertieren (optional)

```bash
# Lege Asteroids ROMs in roms/ ab:
# 035145-04e.ef2, 035144-04e.h2, 035143-02.j2, 035127-02.np3

cd ../romconv
python3 romconv.py
```

### 3. Kompilieren

```bash
# Öffne Arduino IDE
# Datei → Öffnen → asteroidino.ino
# Board: ESP32 Dev Module
# Upload Speed: 921600
# Klicke "Kompilieren"
```

---

## 📂 Projektstruktur

```
asteroidino/
├── BUILD.md          # Detaillierte Build-Anleitung
├── INTEGRATION.md    # CPU-Integration Schritt-für-Schritt
├── README.md         # Hardware-Anforderungen
├── asteroidino/
│   ├── asteroidino.ino  # Haupt-Sketch (jetzt mit mos6502)
│   ├── config.h         # Pin-Definitionen
│   ├── cpu6502.h        # CPU-Header (erstellt)
│   ├── cpu6502.cpp      # CPU-Implementierung (nach setup_cpu.sh)
│   ├── vector_dac.h/cpp # DAC-Treiber (vollständig)
│   └── setup_cpu.sh     # Auto-Download Script
├── romconv/
│   ├── romconv.py       # ROM → C-Array Konverter
│   └── README.md        # ROM-Beschaffung
└── roms/
    └── README.md        # Wo man ROMs herbekommt
```

---

## 🔧 Hardware-Anschlüsse

### MCP4922 (SPI Vector DAC)
```
ESP32 Pin  → MCP4922
GPIO 18    → SCK  (SPI Clock)
GPIO 23    → MOSI (SPI Data)
GPIO 5     → CS   (Chip Select)
3.3V       → VDD
GND        → VSS
```

**Output:** VOUT_A = X, VOUT_B = Y (0-4.095V analog)

### Buttons (active-low mit Pullup)
```
GPIO 12 → Rotate Left
GPIO 14 → Rotate Right  
GPIO 27 → Thrust
GPIO 26 → Hyperspace
GPIO 15 → Fire
GPIO 32 → Start
GPIO 33 → Coin
```

### PCM5102A (I2S Audio)
```
GPIO 25 → LRC (Word Select)
GPIO 26 → BCK (Bit Clock)
GPIO 22 → DIN (Data)
```

---

## 🧪 Test ohne ROMs

Wenn du **noch keine ROMs** hast:

1. Das Projekt kompiliert trotzdem!
2. Es zeigt ein **Test-Pattern** (Kreis) auf dem Vector-Display
3. Serial Monitor zeigt: `"WARNING: ROMs not converted!"`

---

## 📚 Wichtige Dateien erklärt

### `cpu6502.h/cpp`
- Vollständige 6502 CPU-Emulation
- Jump-Table Architektur (schnell auf ESP32)
- Callbacks: `cpu6502_read_callback()`, `cpu6502_write_callback()`

**Verwendung im Code:**
```cpp
cpu = new mos6502(read_callback, write_callback);
cpu->Reset();
cpu->Run(25000, cycle_count);  // 25k cycles/frame
```

### `vector_dac.h/cpp`
- Treiber für MCP4922 Dual-DAC
- 12-Bit Auflösung (0-4095)
- Methoden:
  - `setXY(x, y)` - Setze Vector-Position
  - `test_pattern()` - Zeichne Test-Kreis/Quadrat

### `asteroidino.ino`
- **Core 0 (emulation_task):** CPU läuft mit 1.5 MHz, verarbeitet Vector RAM
- **Core 1 (loop):** Rendert Vektoren zu DAC, liest Buttons

### `romconv.py`
- Konvertiert binäre ROM-Files → C-Header-Arrays
- Memory-Map:
  - `0x6800-0x6FFF` → asteroid_rom_prog1 (035145)
  - `0x7000-0x77FF` → asteroid_rom_prog2 (035144)  
  - `0x7800-0x7FFF` → asteroid_rom_prog3 (035143)

---

## ⚙️ Konfiguration (config.h)

```cpp
// CPU Timing
#define CPU_CLOCK_HZ       1512000    // 1.512 MHz (Asteroids original)
#define CPU_CYCLES_PER_FRAME 25000    // @ 60 Hz

// SPI Pins (Vector DAC)
#define VECT_SPI_CS         5
#define VECT_SPI_CLK        18
#define VECT_SPI_MOSI       23
#define VECT_SPI_SPEED      10000000  // 10 MHz

// Display Settings
#define VECT_POINTS_PER_FRAME  1000
#define VECT_DWELL_US          5      // Microseconds per point
```

---

## 🐛 Troubleshooting

### Fehler: "cpu6502.cpp not found"
→ Führe `setup_cpu.sh` aus! Es lädt die Datei herunter.

### Fehler: "multiple definition of InstrTable"
→ Arduino kompiliert `.cpp` Files automatisch. Stelle sicher, dass `cpu6502.cpp` nur **einmal** im Projekt existiert.

### Serial Monitor zeigt: "WARNING: ROMs not converted"
→ Das ist OK! Ohne ROMs läuft nur das Test-Pattern. Um das Spiel zu starten, brauchst du die Asteroids ROMs.

### DAC zeigt nichts an
→ Prüfe SPI-Verkabelung mit Oszilloskop/Logikanalysator:
```cpp
vector_dac.test_pattern();  // Zeichnet Kreis + Quadrat
```

---

## 🎯 Nächste Schritte

1. **DVG Emulation** - Digital Vector Generator für echte Vector-Befehle
2. **Sound** - Discrete audio oder Samples über I2S
3. **Performance** - Optimize für 60 FPS @ 1.512 MHz
4. **Gehäuse** - 3D-Druck eines Arcade-Cabinets

---

## 📖 Weiterführende Infos

- **Galagino Projekt** (Inspiration): https://github.com/harbaum/galagino
- **mos6502 Library** (CPU): https://github.com/gianlucag/mos6502
- **MAME Asteroids Treiber**: `src/mame/atari/asteroid.cpp`
- **6502 Referenz**: http://www.6502.org/

---

## ✅ Zusammenfassung: Was funktioniert jetzt?

| Feature | Status | Details |
|---------|--------|---------|
| **6502 CPU** | ✅ Vollständig | Alle 151 legalen Opcodes |
| **Memory Map** | ✅ Implementiert | RAM, ROM, Vector RAM |
| **SPI DAC** | ✅ Funktioniert | MCP4922 Treiber mit Test-Pattern |
| **GPIO Input** | ✅ Funktioniert | 7 Buttons mit Pullup |
| **Dual-Core** | ✅ Funktioniert | Core 0: CPU, Core 1: Display |
| **I2S Audio** | ⚠️ Vorbereitet | Setup-Code vorhanden, kein Sound |
| **DVG Emulation** | ❌ TODO | Vector Generator fehlt noch |
| **ROM Loading** | ⚠️ Conditional | Läuft ohne ROMs im Test-Modus |

---

**Viel Erfolg beim Bauen! 🚀**

Bei Problemen lies:
- `BUILD.md` - Build-Anleitung
- `INTEGRATION.md` - CPU-Details
- `README.md` - Hardware-Spezifikation
