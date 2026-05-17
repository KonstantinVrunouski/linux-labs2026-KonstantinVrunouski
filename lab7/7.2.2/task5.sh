#!/bin/bash
read -p "Filename: " file
name=$(basename "$file")
extension="${name##*.}"
basename="${name%.*}"
echo "Name: $basename"
echo "Extension: $extension"
