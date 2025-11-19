#!/usr/bin/env python3
import serial
import sys

port = '/dev/cu.usbserial-110'
baud = 115200

try:
    ser = serial.Serial(port, baud, timeout=1)
    print(f"Reading from {port}...\n", file=sys.stderr)
    
    for i in range(100):  # Read 100 lines
        line = ser.readline().decode('utf-8', errors='ignore')
        if line:
            print(line, end='')
    
    ser.close()
except Exception as e:
    print(f"Error: {e}", file=sys.stderr)
    sys.exit(1)
