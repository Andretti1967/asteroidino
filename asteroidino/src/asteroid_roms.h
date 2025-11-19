/* asteroid_roms.h
 * Combined ROM includes for Asteroids
 * Converted from MAME asteroid.zip
 */

#ifndef ASTEROID_ROMS_H
#define ASTEROID_ROMS_H

// Asteroids ROM Set - Memory Map:
//   0x0000-0x0FFF: RAM (4KB)
//   0x4000-0x47FF: Vector RAM (2KB)
//   0x5000-0x57FF: Vector ROM - 035127-02.np3 (2KB)
//   0x6800-0x6FFF: PROM0 - 035145-04e.ef2 (2KB)
//   0x7000-0x77FF: PROM1 - 035144-04e.h2 (2KB)
//   0x7800-0x7FFF: PROM2 - 035143-02.j2 (2KB)
//
// Note: Program ROMs (6KB total) are mirrored throughout 0x6800-0xFFFF

#include "asteroid_rom_vector.h"
#include "asteroid_rom_prom0.h"
#include "asteroid_rom_prom1.h"
#include "asteroid_rom_prom2.h"

// Mark that ROMs are available
#define ASTEROID_ROMS_CONVERTED 1

#endif // ASTEROID_ROMS_H
