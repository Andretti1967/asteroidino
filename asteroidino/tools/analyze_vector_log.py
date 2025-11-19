#!/usr/bin/env python3
"""
analyze_vector_log.py - Analysiere Vector Logger Dateien

Verwendung:
    python3 analyze_vector_log.py vector_test.csv
    python3 analyze_vector_log.py vector_test.bin --plot
    python3 analyze_vector_log.py vector_test.txt --stats

Features:
    - CSV/Binary/Text Parsing
    - Statistik (Min/Max, Durchschnitt, etc.)
    - Plot mit matplotlib (X/Y Pfad, Z Intensität)
    - Export zu anderen Formaten
"""

import sys
import struct
import argparse
from pathlib import Path

def parse_csv(filename):
    """Parse CSV log file"""
    points = []
    with open(filename, 'r') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#') or line.startswith('frame,'):
                continue
            
            parts = line.split(',')
            if len(parts) >= 4:
                try:
                    frame = int(parts[0])
                    x = int(parts[1]) if parts[1] else None
                    y = int(parts[2]) if parts[2] else None
                    z = int(parts[3]) if parts[3] else None
                    comment = parts[4] if len(parts) > 4 else ""
                    
                    points.append({
                        'frame': frame,
                        'x': x,
                        'y': y,
                        'z': z,
                        'comment': comment
                    })
                except ValueError:
                    continue
    
    return points

def parse_binary(filename):
    """Parse binary log file"""
    points = []
    with open(filename, 'rb') as f:
        # Read header
        magic = f.read(4)
        if magic != b'VEC1':
            print(f"Warning: Invalid magic number: {magic}")
        
        mode = struct.unpack('B', f.read(1))[0]
        print(f"Binary format version: {mode}")
        
        # Read points (6 bytes each: X, Y, Z as uint16 little-endian)
        frame = 0
        while True:
            data = f.read(6)
            if len(data) < 6:
                break
            
            x, y, z = struct.unpack('<HHH', data)
            
            # Check for special markers
            if x == 0xFFFF and y == 0xFFFF:
                if z == 0:
                    points.append({'frame': frame, 'event': 'BLANK'})
                elif z == 0xFFFF:
                    points.append({'frame': frame, 'event': 'UNBLANK'})
                continue
            
            points.append({
                'frame': frame,
                'x': x,
                'y': y,
                'z': z
            })
    
    return points

def print_stats(points):
    """Print statistics about points"""
    if not points:
        print("No points to analyze")
        return
    
    # Filter out events (BLANK/UNBLANK)
    data_points = [p for p in points if 'x' in p and p['x'] is not None]
    
    if not data_points:
        print("No data points found")
        return
    
    x_values = [p['x'] for p in data_points]
    y_values = [p['y'] for p in data_points]
    z_values = [p['z'] for p in data_points if p['z'] is not None]
    
    print("\n=== Statistics ===")
    print(f"Total points: {len(data_points)}")
    print(f"Frames: {max(p['frame'] for p in points) + 1}")
    print(f"\nX range: {min(x_values)} - {max(x_values)}")
    print(f"Y range: {min(y_values)} - {max(y_values)}")
    if z_values:
        print(f"Z range: {min(z_values)} - {max(z_values)}")
        print(f"Z average: {sum(z_values) / len(z_values):.1f}")
    
    # Blank events
    blank_events = len([p for p in points if 'event' in p and p['event'] == 'BLANK'])
    unblank_events = len([p for p in points if 'event' in p and p['event'] == 'UNBLANK'])
    print(f"\nBlank events: {blank_events}")
    print(f"Unblank events: {unblank_events}")

def plot_points(points, output=None):
    """Plot points with matplotlib"""
    try:
        import matplotlib.pyplot as plt
        import numpy as np
    except ImportError:
        print("Error: matplotlib not installed. Install with: pip3 install matplotlib")
        return
    
    data_points = [p for p in points if 'x' in p and p['x'] is not None]
    if not data_points:
        print("No data points to plot")
        return
    
    x = [p['x'] for p in data_points]
    y = [p['y'] for p in data_points]
    z = [p['z'] if p['z'] is not None else 0 for p in data_points]
    
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))
    
    # X/Y Plot mit Z als Farbe
    scatter = ax1.scatter(x, y, c=z, cmap='hot', s=1, alpha=0.6)
    ax1.set_xlabel('X')
    ax1.set_ylabel('Y')
    ax1.set_title('Vector Display Output (X/Y)')
    ax1.set_xlim(0, 4096)
    ax1.set_ylim(0, 4096)
    ax1.set_aspect('equal')
    ax1.grid(True, alpha=0.3)
    plt.colorbar(scatter, ax=ax1, label='Z (Intensity)')
    
    # Z über Zeit
    ax2.plot(z, linewidth=0.5)
    ax2.set_xlabel('Point Index')
    ax2.set_ylabel('Z (Intensity)')
    ax2.set_title('Beam Intensity over Time')
    ax2.set_ylim(0, 4096)
    ax2.grid(True, alpha=0.3)
    
    plt.tight_layout()
    
    if output:
        plt.savefig(output, dpi=150)
        print(f"Plot saved to {output}")
    else:
        plt.show()

def export_to_csv(points, output_filename):
    """Export points to CSV"""
    with open(output_filename, 'w') as f:
        f.write("frame,x,y,z,comment\n")
        for p in points:
            if 'event' in p:
                f.write(f"{p['frame']},,,{p['event']}\n")
            else:
                x = p['x'] if p['x'] is not None else ''
                y = p['y'] if p['y'] is not None else ''
                z = p['z'] if p['z'] is not None else ''
                comment = p.get('comment', '')
                f.write(f"{p['frame']},{x},{y},{z},{comment}\n")
    
    print(f"Exported to {output_filename}")

def main():
    parser = argparse.ArgumentParser(description='Analyze Vector Logger files')
    parser.add_argument('filename', help='Input file (CSV, BIN, or TXT)')
    parser.add_argument('--stats', action='store_true', help='Print statistics')
    parser.add_argument('--plot', action='store_true', help='Plot data with matplotlib')
    parser.add_argument('--output', help='Output filename for plot or export')
    parser.add_argument('--export-csv', action='store_true', help='Export to CSV format')
    
    args = parser.parse_args()
    
    # Determine file type
    ext = Path(args.filename).suffix.lower()
    
    print(f"Loading {args.filename}...")
    
    if ext == '.csv':
        points = parse_csv(args.filename)
    elif ext == '.bin':
        points = parse_binary(args.filename)
    else:
        print(f"Warning: Unknown file type '{ext}', trying CSV format")
        points = parse_csv(args.filename)
    
    print(f"Loaded {len(points)} points")
    
    # Always print stats
    print_stats(points)
    
    # Optional actions
    if args.plot:
        plot_points(points, args.output)
    
    if args.export_csv:
        output = args.output or 'export.csv'
        export_to_csv(points, output)

if __name__ == '__main__':
    main()
