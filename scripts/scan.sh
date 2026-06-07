#!/usr/bin/env bash
# scan.sh
set -euo pipefail

OUTDIR="$HOME/Documents/Scans"
mkdir -p "$OUTDIR"

BASENAME="scan-$(date +%Y-%m-%d_%H-%M-%S)"

PNG="$OUTDIR/$BASENAME.png"
PDF="$OUTDIR/$BASENAME.pdf"

if ping -c1 -W1 192.168.1.79 >/dev/null 2>&1; then
    DEVICE="epsonds:net:192.168.1.79"
elif ping -c1 -W1 192.168.1.10 >/dev/null 2>&1; then
    DEVICE="epsonds:net:192.168.1.10"
else
    echo "No scanner available"
    exit 1
fi

scanimage \
  -d "$DEVICE" \
  --mode Color \
  --resolution 150 \
  --format=png \
  > "$PNG"

img2pdf "$PNG" -o "$PDF"

echo "PNG: $PNG"
echo "PDF: $PDF"
