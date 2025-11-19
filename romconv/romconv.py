#!/usr/bin/env python3
"""
romconv.py - Konvertiert Asteroids ROM-Dateien zu C-Header-Arrays

Basiert auf Galagino's romconv.py, angepasst für Asteroids

Usage:
    python3 romconv.py

Benötigte ROM-Dateien (in ../roms/):
    035145-02.ef2   - Programm ROM 1 (2KB) - Rev 2
    035144-02.h2    - Programm ROM 2 (2KB) - Rev 2
    035143-02.j2    - Programm ROM 3 (2KB) - Rev 2
    035127-02.np3   - Vector ROM (2KB)
"""

import os
import sys

# ROM-Dateien für Asteroids (Rev 2)
ROMS = {
    'prog1': {
        'file': '035145-02.ef2',
        'size': 2048,
        'addr': 0x6800,
        'desc': 'Program ROM 1 (Rev 2)'
    },
    'prog2': {
        'file': '035144-02.h2',
        'size': 2048,
        'addr': 0x7000,
        'desc': 'Program ROM 2 (Rev 2)'
    },
    'prog3': {
        'file': '035143-02.j2',
        'size': 2048,
        'addr': 0x7800,
        'desc': 'Program ROM 3 (Rev 2)'
    },
    'vector': {
        'file': '035127-02.np3',
        'size': 2048,
        'addr': 0x5000,  # Vector state machine ROM
        'desc': 'Vector ROM'
    }
}

def rom_to_c_array(rom_name, rom_info, output_dir):
    """Konvertiert eine ROM-Datei zu einem C-Header-Array"""
    rom_path = os.path.join('..', 'roms', rom_info['file'])
    
    if not os.path.exists(rom_path):
        print(f"ERROR: ROM file not found: {rom_path}")
        return False
    
    # ROM-Daten einlesen
    with open(rom_path, 'rb') as f:
        data = f.read()
    
    if len(data) != rom_info['size']:
        print(f"WARNING: {rom_info['file']} is {len(data)} bytes, expected {rom_info['size']}")
    
    # C-Header generieren
    header_name = f"asteroid_rom_{rom_name}.h"
    header_path = os.path.join(output_dir, header_name)
    
    with open(header_path, 'w') as f:
        f.write(f"/* {header_name}\n")
        f.write(f" * {rom_info['desc']}\n")
        f.write(f" * Auto-generated from {rom_info['file']}\n")
        f.write(f" * Size: {rom_info['size']} bytes\n")
        f.write(f" * Load address: 0x{rom_info['addr']:04X}\n")
        f.write(f" */\n\n")
        f.write(f"#ifndef ASTEROID_ROM_{rom_name.upper()}_H\n")
        f.write(f"#define ASTEROID_ROM_{rom_name.upper()}_H\n\n")
        f.write(f"const unsigned char asteroid_rom_{rom_name}[{len(data)}] = {{\n")
        
        # Daten in Zeilen zu je 16 bytes
        for i in range(0, len(data), 16):
            chunk = data[i:i+16]
            hex_values = ', '.join(f'0x{b:02X}' for b in chunk)
            f.write(f"  {hex_values},\n")
        
        f.write("};\n\n")
        f.write(f"#endif // ASTEROID_ROM_{rom_name.upper()}_H\n")
    
    print(f"✓ Created {header_name} ({len(data)} bytes)")
    return True

def create_combined_rom(output_dir):
    """Erstellt einen kombinierten ROM-Header mit allen Teilen"""
    header_path = os.path.join(output_dir, "asteroid_roms.h")
    
    with open(header_path, 'w') as f:
        f.write("/* asteroid_roms.h\n")
        f.write(" * Combined ROM includes for Asteroids\n")
        f.write(" * Auto-generated - do not edit manually\n")
        f.write(" */\n\n")
        f.write("#ifndef ASTEROID_ROMS_H\n")
        f.write("#define ASTEROID_ROMS_H\n\n")
        
        for rom_name in ROMS.keys():
            f.write(f"#include \"asteroid_rom_{rom_name}.h\"\n")
        
        f.write("\n// ROM memory map helper\n")
        f.write("struct asteroid_rom_map {\n")
        for rom_name, rom_info in ROMS.items():
            if rom_name != 'color':  # Color PROM nicht im main memory
                f.write(f"  const unsigned char *{rom_name};  // 0x{rom_info['addr']:04X}\n")
        f.write("};\n\n")
        
        f.write("static const struct asteroid_rom_map asteroid_roms = {\n")
        for rom_name, rom_info in ROMS.items():
            if rom_name != 'color':
                f.write(f"  .{rom_name} = asteroid_rom_{rom_name},\n")
        f.write("};\n\n")
        
        f.write("#endif // ASTEROID_ROMS_H\n")
    
    print(f"✓ Created asteroid_roms.h (combined header)")

def main():
    print("Asteroidino ROM Converter")
    print("=" * 50)
    
    # Output-Verzeichnis
    output_dir = os.path.join('..', 'asteroidino')
    if not os.path.exists(output_dir):
        print(f"ERROR: Output directory not found: {output_dir}")
        return 1
    
    # Prüfe, ob ROM-Verzeichnis existiert
    rom_dir = os.path.join('..', 'roms')
    if not os.path.exists(rom_dir):
        print(f"ERROR: ROM directory not found: {rom_dir}")
        print("Please create '../roms/' and place Asteroids ROM files there")
        return 1
    
    # Konvertiere alle ROMs
    success_count = 0
    for rom_name, rom_info in ROMS.items():
        if rom_to_c_array(rom_name, rom_info, output_dir):
            success_count += 1
    
    if success_count == len(ROMS):
        # Erstelle combined header
        create_combined_rom(output_dir)
        print("\n" + "=" * 50)
        print(f"✓ Successfully converted all {success_count} ROM files")
        print("\nNext steps:")
        print("1. Open asteroidino/asteroidino.ino in Arduino IDE")
        print("2. Select Board: ESP32 Dev Module")
        print("3. Compile and upload to ESP32")
        return 0
    else:
        print(f"\n✗ Only {success_count}/{len(ROMS)} ROMs converted successfully")
        print("Please check ROM files in '../roms/' directory")
        return 1

if __name__ == '__main__':
    sys.exit(main())
