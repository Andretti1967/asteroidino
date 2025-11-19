#!/bin/bash
#
# capture_serial_log.sh - Empfange Vector Logger Daten vom ESP32
#
# Verwendung:
#   ./capture_serial_log.sh /dev/ttyUSB0 vectors.csv
#   ./capture_serial_log.sh /dev/cu.usbserial-0001 vectors.bin
#

PORT="${1:-/dev/ttyUSB0}"
OUTPUT="${2:-vectors.csv}"
BAUD="${3:-115200}"

if [ -z "$1" ]; then
    echo "Usage: $0 <serial_port> <output_file> [baud_rate]"
    echo ""
    echo "Examples:"
    echo "  $0 /dev/ttyUSB0 vectors.csv"
    echo "  $0 /dev/cu.usbserial-0001 vectors.bin"
    echo ""
    echo "Available ports:"
    ls -1 /dev/tty* | grep -i "usb\|serial" | head -5
    exit 1
fi

if [ ! -e "$PORT" ]; then
    echo "Error: Port '$PORT' not found!"
    echo ""
    echo "Available ports:"
    ls -1 /dev/tty* | grep -i "usb\|serial" | head -5
    exit 1
fi

echo "═══════════════════════════════════════"
echo "  ESP32 Vector Logger Capture"
echo "═══════════════════════════════════════"
echo "Port:   $PORT"
echo "Output: $OUTPUT"
echo "Baud:   $BAUD"
echo ""
echo "Press Ctrl+C to stop capturing..."
echo "═══════════════════════════════════════"
echo ""

# Capture serial data
# stty: konfiguriere Port
# cat: lese Daten
stty -F "$PORT" "$BAUD" raw -echo 2>/dev/null || stty -f "$PORT" "$BAUD" raw -echo 2>/dev/null
cat "$PORT" > "$OUTPUT"

echo ""
echo "Capture stopped."
echo "File saved: $OUTPUT ($(wc -c < "$OUTPUT") bytes)"
