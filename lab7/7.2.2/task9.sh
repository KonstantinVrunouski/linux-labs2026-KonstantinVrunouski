#!/bin/bash
outdir="$HOME/webcam_photos"
mkdir -p "$outdir"
if ! command -v fswebcam &>/dev/null; then
    echo "fswebcam not found, installing..."
    sudo apt update && sudo apt install -y fswebcam
fi
fswebcam "$outdir/photo_$(date +%Y%m%d_%H%M%S).jpg"
