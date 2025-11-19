# CPU6502 Integration - Komplette Anleitung

## Schritt 1: Originale mos6502 Library herunterladen

```bash
cd /Users/andres/mame/asteroidino
curl -O https://raw.githubusercontent.com/gianlucag/mos6502/main/mos6502.cpp
curl -O https://raw.githubusercontent.com/gianlucag/mos6502/main/mos6502.h
```

## Schritt 2: Dateien anpassen für Arduino

Die originalen Dateien müssen für ESP32 angepasst werden:

### 2a) mos6502.cpp → cpu6502.cpp

Ändere in `mos6502.cpp`:

```cpp
// Zeile 1: Include ändern
#include "cpu6502.h"  // statt "mos6502.h"
```

### 2b) mos6502.h → cpu6502.h

Die Datei `cpu6502.h` wurde bereits erstellt (siehe aktuellen Stand).

### 2c) Rename

```bash
mv mos6502.cpp cpu6502.cpp
rm mos6502.h  # Wir nutzen die angepasste cpu6502.h
```

## Schritt 3: Arduino Sketch anpassen

Ersetze in `asteroidino.ino`:

```cpp
// ALT:
// #include "cpu6502.h"
// void cpu6502_reset() { ... }
// void cpu6502_step() { ... }

// NEU:
#include "cpu6502.h"

// Globale CPU-Instanz
mos6502* cpu = nullptr;

// Memory callbacks
uint8_t asteroids_read(uint16_t address) {
    // ROM: 0x0000-0x7FFF
    if (address < 0x8000) {
        return asteroids_rom[address];
    }
    // RAM: 0x8000-0x8FFF
    else if (address < 0x9000) {
        return asteroids_ram[address - 0x8000];
    }
    // Vector RAM: 0x9000-0x9FFF
    else if (address < 0xA000) {
        return vector_ram[address - 0x9000];
    }
    return 0xFF;
}

void asteroids_write(uint16_t address, uint8_t value) {
    // RAM: 0x8000-0x8FFF
    if (address >= 0x8000 && address < 0x9000) {
        asteroids_ram[address - 0x8000] = value;
    }
    // Vector RAM: 0x9000-0x9FFF
    else if (address >= 0x9000 && address < 0xA000) {
        vector_ram[address - 0x9000] = value;
    }
}

void setup() {
    Serial.begin(115200);
    
    // CPU initialisieren mit Callbacks
    cpu = new mos6502(asteroids_read, asteroids_write);
    cpu->Reset();
    
    // ... rest of setup ...
}

void emulation_task(void* param) {
    while (true) {
        uint64_t cycleCount = 0;
        
        // CPU läuft für 1 Frame (25000 Zyklen @ 1.5MHz)
        cpu->Run(CPU_CYCLES_PER_FRAME, cycleCount);
        
        vTaskDelay(1);  // 60 FPS
    }
}
```

## Schritt 4: Kompilieren

1. Öffne Arduino IDE
2. Datei → Öffnen → `asteroidino.ino`
3. Board: "ESP32 Dev Module"
4. Upload Speed: "921600"
5. Klicke "Kompilieren"

## Fertig!

Du hast jetzt alle 151 6502-Opcodes implementiert:
- ✅ Alle arithmetischen Operationen (ADC, SBC, INC, DEC)
- ✅ Alle logischen Operationen (AND, ORA, EOR)
- ✅ Alle Shift/Rotate (ASL, LSR, ROL, ROR)
- ✅ Alle Branches (BEQ, BNE, BCC, BCS, BMI, BPL, BVC, BVS)
- ✅ Alle Load/Store (LDA, LDX, LDY, STA, STX, STY)
- ✅ Alle Sprünge (JMP, JSR, RTS, RTI)
- ✅ Stack-Operationen (PHA, PLA, PHP, PLP)
- ✅ Vergleiche (CMP, CPX, CPY, BIT)
- ✅ Register-Transfers (TAX, TAY, TSX, TXA, TXS, TYA)
- ✅ Flag-Operationen (CLC, CLD, CLI, CLV, SEC, SED, SEI)

## Troubleshooting

### Fehler: "mos6502 does not name a type"
→ Prüfe, ob `cpu6502.h` und `cpu6502.cpp` im gleichen Verzeichnis wie `asteroidino.ino` liegen.

### Fehler: "multiple definition of InstrTable"
→ Die Datei `cpu6502.cpp` darf nur **einmal** kompiliert werden. Arduino macht das automatisch.

### Fehler: "'ILLEGAL_OPCODES' was not declared"
→ Stelle sicher, dass in `cpu6502.cpp` die Zeile `#define ILLEGAL_OPCODES` **auskommentiert** ist (für Asteroids nicht nötig).

## Nächste Schritte

Nach der CPU-Emulation fehlen noch:

1. **DVG (Digital Vector Generator)** - Konvertiert Vector RAM → Punkte
2. **Discrete Sound** - Audio-Output über I2S
3. **Hardware-Test** - Auf echtem ESP32 mit MCP4922 DAC
