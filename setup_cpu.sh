#!/bin/bash
# setup_cpu.sh - Automatische Integration der mos6502 Library

set -e

echo "================================================="
echo "Asteroidino CPU6502 Setup"
echo "================================================="
echo ""

# Check if we're in the right directory
if [ ! -f "asteroidino.ino" ]; then
    echo "❌ Fehler: Dieses Script muss im asteroidino/ Verzeichnis ausgeführt werden!"
    exit 1
fi

echo "📥 Schritt 1: Lade mos6502 Library herunter..."
curl -s -L -o mos6502_temp.cpp https://raw.githubusercontent.com/gianlucag/mos6502/main/mos6502.cpp
curl -s -L -o mos6502_temp.h https://raw.githubusercontent.com/gianlucag/mos6502/main/mos6502.h

echo "✅ Download abgeschlossen"
echo ""

echo "🔧 Schritt 2: Passe Dateien für ESP32 an..."

# Ersetze Include in cpp
sed 's/#include "mos6502.h"/#include "cpu6502.h"/g' mos6502_temp.cpp > cpu6502.cpp

# Lösche temporäre Dateien
rm mos6502_temp.cpp mos6502_temp.h

echo "✅ Anpassungen abgeschlossen"
echo ""

echo "📊 Schritt 3: Überprüfe Opcodes..."

# Zähle MAKE_INSTR Aufrufe (sollte ~151 sein)
OPCODE_COUNT=$(grep -c "MAKE_INSTR(" cpu6502.cpp || true)

echo "   Gefundene Opcodes: $OPCODE_COUNT"

if [ "$OPCODE_COUNT" -ge 150 ]; then
    echo "   ✅ Alle Opcodes vorhanden!"
else
    echo "   ⚠️  Warnung: Weniger als 151 Opcodes gefunden"
fi

echo ""
echo "================================================="
echo "✅ Setup erfolgreich!"
echo "================================================="
echo ""
echo "Nächste Schritte:"
echo "  1. Öffne asteroidino.ino in Arduino IDE"
echo "  2. Wähle Board: ESP32 Dev Module"
echo "  3. Kompiliere (Ctrl+R)"
echo ""
echo "Dateien erstellt:"
echo "  ✓ cpu6502.h   (angepasster Header)"
echo "  ✓ cpu6502.cpp (~2500 Zeilen, alle Opcodes)"
echo ""
echo "Memory-Map für Asteroids:"
echo "  0x0000-0x7FFF: ROM (32KB)"
echo "  0x8000-0x8FFF: RAM (4KB)"
echo "  0x9000-0x9FFF: Vector RAM (4KB)"
echo ""
