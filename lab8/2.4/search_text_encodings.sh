#!/bin/bash
ENC_DIR="$(cd "$(dirname "$0")/encodings" && pwd)"
find "$ENC_DIR" -type f | while read -r f; do
    case "$f" in
        *.utf8) enc_from="UTF-8" ;;
        *.cp1251) enc_from="CP1251" ;;
        *.koi8) enc_from="KOI8-R" ;;
        *) continue ;;
    esac
    if iconv -f "$enc_from" -t UTF-8 "$f" 2>/dev/null | grep -q 'Текст'; then
        echo "FOUND [$enc_from]: $f"
    fi
done
