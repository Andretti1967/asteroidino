# ROM-Dateien für Asteroidino

Dieses Verzeichnis soll die Original-Asteroids ROM-Dateien enthalten.

## Benötigte Dateien

Für Asteroids (Rev 4):

```
035145-04e.ef2  - Program ROM 1 (2048 bytes)
035144-04e.h2   - Program ROM 2 (2048 bytes)
035143-02.j2    - Program ROM 3 (2048 bytes)
035127-02.np3   - Vector ROM (2048 bytes)
034602-01.c8    - Color PROM (256 bytes)
```

## Wo bekomme ich die ROMs?

Die ROM-Dateien sind **nicht** im Repository enthalten aus urheberrechtlichen Gründen.

Möglichkeiten:
1. **MAME ROM Set**: Wenn du bereits ein MAME ROM-Set hast, findest du die Dateien im `asteroid.zip`
2. **Original Arcade Board**: Wenn du ein Original-Board besitzt, kannst du die ROMs auslesen
3. **Internet Archive**: Suche nach "Asteroids arcade rom" (auf eigene Verantwortung)

## Verwendung

1. Lege die ROM-Dateien in dieses Verzeichnis (`roms/`)
2. Führe das Konvertierungsskript aus:
   ```bash
   cd ../romconv
   python3 romconv.py
   ```
3. Die konvertierten Header-Dateien werden im `asteroidino/` Verzeichnis erstellt

## Checksums (zur Verifikation)

Wenn du sicherstellen möchtest, dass du die richtigen ROM-Dateien hast:

```
035145-04e.ef2: CRC32: 0x???  (TODO: Add checksums)
035144-04e.h2:  CRC32: 0x???
035143-02.j2:   CRC32: 0x???
035127-02.np3:  CRC32: 0x???
034602-01.c8:   CRC32: 0x???
```

## Andere Asteroids-Versionen

Dieses Projekt ist aktuell für **Asteroids Rev 4** ausgelegt.
Andere Versionen (Rev 1, 2, Deluxe, etc.) haben andere ROM-Dateien
und Memory-Maps.

Wenn du eine andere Version verwenden möchtest, musst du:
1. `romconv/romconv.py` anpassen (Dateinamen, Adressen)
2. Eventuell `asteroidino/asteroidino.ino` anpassen (Memory-Map)
