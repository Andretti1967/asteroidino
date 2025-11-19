#!/usr/bin/env python3
"""
Asteroids ROM to C Header Converter
Converts Asteroids arcade ROM files to C header arrays for ESP32

ROM Memory Map:
- Vector RAM:  0x4000-0x47FF (2KB) - Not converted, allocated at runtime
- Vector ROM:  0x5000-0x57FF (2KB) - 035127-02.np3
- PROM0:       0x6800-0x6FFF (2KB) - 035145-04e.ef2
- PROM1:       0x7000-0x77FF (2KB) - 035144-04e.h2
- PROM2:       0x7800-0x7FFF (2KB) - 035143-02.j2

The 6KB program ROM space (0x6800-0x7FFF) is mirrored throughout 0x6800-0xFFFF
to provide access to reset vectors at 0xFFFC-0xFFFF.
"""

import os
import sys

def convert_rom_to_header(input_file, output_file, array_name, description):
    """Convert binary ROM to C header file"""
    
    # Read ROM data
    try:
        with open(input_file, 'rb') as f:
            data = f.read()
    except FileNotFoundError:
        print(f"Error: File '{input_file}' not found!")
        return False
    
    rom_size = len(data)
    print(f"Converting {input_file} ({rom_size} bytes) -> {output_file}")
    
    # Generate C header
    with open(output_file, 'w') as f:
        # Header guard
        guard_name = array_name.upper() + "_H"
        f.write(f"#ifndef {guard_name}\n")
        f.write(f"#define {guard_name}\n\n")
        
        # Description comment
        f.write(f"// {description}\n")
        f.write(f"// Source: {input_file}\n")
        f.write(f"// Size: {rom_size} bytes\n\n")
        
        # Array declaration with PROGMEM for ESP32
        f.write(f"#include <Arduino.h>\n\n")
        f.write(f"const uint8_t PROGMEM {array_name}[{rom_size}] = {{\n")
        
        # Write data in rows of 16 bytes
        for i in range(0, rom_size, 16):
            f.write("    ")
            for j in range(16):
                if i + j < rom_size:
                    f.write(f"0x{data[i+j]:02X}")
                    if i + j < rom_size - 1:
                        f.write(", ")
                    if j == 15 or i + j == rom_size - 1:
                        f.write(f"  // 0x{i+j:04X}")
            f.write("\n")
        
        f.write("};\n\n")
        f.write(f"#endif // {guard_name}\n")
    
    print(f"  → Created {output_file} with array '{array_name}'")
    return True

def main():
    print("=" * 70)
    print("Asteroids ROM Converter")
    print("=" * 70)
    print()
    
    # Check if ROM files exist
    rom_files = {
        'vector': '035127-02.np3',
        'prom0': '035145-04e.ef2',
        'prom1': '035144-04e.h2',
        'prom2': '035143-02.j2'
    }
    
    for name, filename in rom_files.items():
        if not os.path.exists(filename):
            print(f"ERROR: {filename} not found!")
            print(f"Please place ROM files in this directory.")
            return 1
    
    print("Found all required ROM files.\n")
    
    # Convert each ROM
    conversions = [
        ('035127-02.np3', '../src/asteroid_rom_vector.h', 'asteroid_rom_vector',
         'Asteroids Vector ROM (035127-02) - Address: 0x5000-0x57FF'),
        ('035145-04e.ef2', '../src/asteroid_rom_prom0.h', 'asteroid_rom_prom0',
         'Asteroids PROM0 (035145-04e) - Address: 0x6800-0x6FFF'),
        ('035144-04e.h2', '../src/asteroid_rom_prom1.h', 'asteroid_rom_prom1',
         'Asteroids PROM1 (035144-04e) - Address: 0x7000-0x77FF'),
        ('035143-02.j2', '../src/asteroid_rom_prom2.h', 'asteroid_rom_prom2',
         'Asteroids PROM2 (035143-02) - Address: 0x7800-0x7FFF'),
    ]
    
    success_count = 0
    for input_file, output_file, array_name, description in conversions:
        if convert_rom_to_header(input_file, output_file, array_name, description):
            success_count += 1
        print()
    
    if success_count == len(conversions):
        print("=" * 70)
        print("SUCCESS! All ROM files converted.")
        print("=" * 70)
        print()
        print("Memory Map:")
        print("  0x4000-0x47FF: Vector RAM (allocated at runtime)")
        print("  0x5000-0x57FF: Vector ROM (asteroid_rom_vector)")
        print("  0x6800-0x6FFF: PROM0 (asteroid_rom_prom0)")
        print("  0x7000-0x77FF: PROM1 (asteroid_rom_prom1)")
        print("  0x7800-0x7FFF: PROM2 (asteroid_rom_prom2)")
        print()
        print("Note: Program ROMs are mirrored throughout 0x6800-0xFFFF")
        return 0
    else:
        print(f"ERROR: Only {success_count}/{len(conversions)} conversions succeeded")
        return 1

if __name__ == '__main__':
    sys.exit(main())
