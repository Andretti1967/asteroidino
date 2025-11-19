# Asteroidino - Asteroids auf ESP32

Ein Asteroids Arcade-Emulator für ESP32 mit Vektor-Ausgabe über SPI DAC, inspiriert von [Galagino](https://github.com/harbaum/galagino).

![Status](https://img.shields.io/badge/status-proof--of--concept-yellow)

## Hardware-Anforderungen

### Minimal-Setup (Breadboard)

- **ESP32-WROOM Entwicklungsboard** (z.B. DevKit V4)
- **Dual SPI DAC** für X/Y Vektor-Ausgabe
  - Empfohlen: MCP4922 (2x 12-bit DAC, SPI)
  - Alternative: MCP4822 (2x 8-bit, günstiger)
- **I2S DAC** für Audio
  - Empfohlen: PCM5102A oder UDA1334A
  - Alternative: PAM8302A Verstärker + Lautsprecher
- **5 Taster** oder 2-Achsen-Joystick + 2 Taster
  - Fire (Feuer)
  - Hyperspace (Hyperraum)
  - Rotate Left/Right (Links/Rechts drehen)
  - Thrust (Schub)
  - Start
  - Coin (Münze)
- **Oszilloskop oder XY-Vector-Display** zum Testen
  - Für echtes Arcade-Feeling: Vectrex-Monitor oder CRT mit XY-Eingang
  - Zum Debuggen: Oszilloskop im XY-Modus

### Pin-Belegung (siehe `asteroidino/config.h`)

```
SPI DAC (MCP4922):
  CS:    GPIO 5
  SCK:   GPIO 18
  MOSI:  GPIO 23
  
I2S Audio:
  BCK:   GPIO 26
  WS:    GPIO 25
  DATA:  GPIO 22

Buttons/GPIO:
  LEFT:  GPIO 32
  RIGHT: GPIO 33
  UP:    GPIO 34 (Thrust)
  DOWN:  GPIO 35 (Hyperspace)
  FIRE:  GPIO 15
  START: GPIO 14
  COIN:  GPIO 27
```

## Software-Installation

### Voraussetzungen

1. **Arduino IDE** (empfohlen: 1.8.19 oder 2.x)
2. **ESP32 Board Support** (Version 2.0.9 oder älter - wegen I2S-Bug in 2.0.10+)
3. **Python 3** für ROM-Konvertierung

### Schritt 1: Asteroids ROM-Dateien beschaffen

Die Original-ROM-Dateien werden NICHT mit diesem Projekt ausgeliefert (Urheberrecht).
Du musst sie selbst beschaffen (z.B. aus einem MAME ROM-Set).

Benötigte Dateien (für Asteroids Rev 4):
```
035145-04e.ef2
035144-04e.h2
035143-02.j2
035127-02.np3
034602-01.c8
```

Lege diese Dateien in den `roms/` Ordner.

### Schritt 2: ROMs konvertieren

```bash
cd romconv
python3 romconv.py
```

Dies erstellt die Header-Dateien im `asteroidino/` Verzeichnis.

### Schritt 3: In Arduino IDE öffnen und kompilieren

1. Öffne `asteroidino/asteroidino.ino`
2. Wähle Board: "ESP32 Dev Module"
3. Stelle sicher, dass Core 1 für Arduino genutzt wird (default)
4. Kompiliere und lade hoch

## Architektur

### Unterschiede zu Galagino

| Aspekt | Galagino | Asteroidino |
|--------|----------|-------------|
| CPU | Z80 @ 3 MHz (x3) | 6502 @ 1.5 MHz (x1) |
| Display | Raster (Tiles+Sprites) | Vektor (Linien) |
| Ausgabe | SPI TFT (ILI9341) | SPI DAC (analog X/Y) |
| Audio | Namco WSG / AY-3-8910 | Atari Discrete + POKEY |
| Video-RAM | 8 KB | ~1 KB (Vector-RAM) |

### Emulations-Strategie

```
Core 0 (Video/Audio):
- Vector-Liste aus DVG dekodieren
- X/Y-Werte über SPI DAC ausgeben
- Audio-Buffer füllen (I2S)
- ~60 Hz Refresh

Core 1 (Emulation):
- 6502 CPU emulieren (~12500 inst/frame @ 60Hz)
- DVG (Digital Vector Generator) emulieren
- POKEY sound chip emulieren
- Button-Input lesen
```

### Vector-Rendering

Asteroids nutzt einen **Digital Vector Generator (DVG)**, der Linienzüge als
kompakte Befehle speichert. Die Emulation:

1. **DVG dekodieren**: Befehle aus 0x4000-0x47FF lesen
2. **Punkte sammeln**: Linien in diskrete Punkte (X, Y, Intensity) umwandeln
3. **SPI ausgeben**: Pro Frame alle Punkte sequenziell an DAC senden
4. **Timing**: Cursor-Bewegung muss schnell genug sein (>30 kHz Punktrate)

## Aktuelle Einschränkungen

- [ ] Vector-Display-Emulation vereinfacht (Punkte statt echte Linien)
- [ ] Sound-Emulation rudimentär (nur einfache Töne)
- [ ] Keine Farbunterstützung (Monochrom)
- [ ] GPIO-Entprellen rudimentär

## Roadmap

- [x] Projekt-Struktur anlegen
- [ ] 6502-Emulator integrieren
- [ ] ROM-Converter schreiben
- [ ] DVG-Emulation (Vektor-Dekoder)
- [ ] SPI DAC-Treiber
- [ ] I2S Audio-Treiber
- [ ] Input-Handler (GPIO)
- [ ] Test mit echtem Hardware
- [ ] Optimierung (Blanking, Flicker-Reduktion)

## Lizenz

- **6502-Emulator**: Mike Chambers' fake6502 (CC0 / Public Domain)
- **Projekt-Code**: GPLv3 (analog zu Galagino)
- **Asteroids ROMs**: © Atari (nicht im Repository enthalten)

## Credits

- Till Harbaum für Galagino (Inspiration und Architektur-Vorbild)
- Mike Chambers für fake6502
- Atari für das Original Asteroids (1979)
