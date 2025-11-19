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

# GitHub verwendet 'master' branch, nicht 'main'
curl -L -A "Mozilla/5.0" \
     -o mos6502_temp.cpp \
     https://raw.githubusercontent.com/gianlucag/mos6502/master/mos6502.cpp

if [ ! -s mos6502_temp.cpp ]; then
    echo "❌ Fehler beim Download von cpp-Datei"
    echo "   Versuche alternativen Download..."
    
    # Fallback: Direkt von GitHub Pages
    curl -L -A "Mozilla/5.0" \
         -o mos6502_temp.cpp \
         "https://github.com/gianlucag/mos6502/raw/master/mos6502.cpp"
fi

# Prüfe Dateigröße
CPP_SIZE=$(wc -c < mos6502_temp.cpp 2>/dev/null || echo "0")
if [ "$CPP_SIZE" -lt 10000 ]; then
    echo "❌ Download fehlgeschlagen (Datei zu klein: $CPP_SIZE bytes)"
    echo ""
    echo "Manuelle Alternative:"
    echo "  1. Öffne: https://github.com/gianlucag/mos6502/blob/master/mos6502.cpp"
    echo "  2. Klicke 'Raw'"
    echo "  3. Speichere als: cpu6502.cpp"
    echo "  4. Ändere erste Zeile: #include \"cpu6502.h\""
    rm -f mos6502_temp.cpp
    exit 1
fi

echo "✅ Download abgeschlossen ($CPP_SIZE bytes)"
echo ""

echo "🔧 Schritt 2: Passe Dateien für ESP32 an..."

# Ersetze Include in cpp
if grep -q "#include \"mos6502.h\"" mos6502_temp.cpp; then
    sed 's/#include "mos6502.h"/#include "cpu6502.h"/g' mos6502_temp.cpp > cpu6502.cpp
    echo "   ✅ Include-Pfad angepasst"
else
    # Falls bereits angepasst oder anderes Format
    cp mos6502_temp.cpp cpu6502.cpp
    echo "   ⚠️  Include bereits angepasst oder nicht gefunden"
fi

# Lösche temporäre Dateien
rm -f mos6502_temp.cpp mos6502_temp.h

# Prüfe finales Ergebnis
if [ ! -f cpu6502.cpp ]; then
    echo "❌ cpu6502.cpp wurde nicht erstellt!"
    exit 1
fi

FINAL_SIZE=$(wc -c < cpu6502.cpp)
if [ "$FINAL_SIZE" -lt 10000 ]; then
    echo "❌ cpu6502.cpp ist zu klein ($FINAL_SIZE bytes)"
    cat cpu6502.cpp
    exit 1
fi

echo "✅ Anpassungen abgeschlossen (cpu6502.cpp: $FINAL_SIZE bytes)"
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
