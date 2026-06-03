#!/bin/bash


if [ $# -ne 1 ]; then
    echo "Usage: $0 <access_log_file>"
    exit 1
fi

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' not found."
    exit 1
fi


awk '
/ [3][0-9]{2} / {
    ua = $NF
    gsub(/\/[0-9].*$/, "", ua)
    gsub(/ [0-9].*$/, "", ua)
    gsub(/\(.*$/, "", ua)
    gsub(/^"|"$/, "", ua)
    if (ua == "" || ua == "-") ua = "Unknown"
    count[ua]++
    total++
}
END {
    for (ua in count) {
        perc = (count[ua] * 100) / total
        printf "%d\t%s\t%.0f%%\n", count[ua], ua, perc
    }
}
' "$LOG_FILE" | sort -rn -k1,1 | head -10 | awk '
BEGIN { print "Топ-10 программ, перенаправленных сервером (3xx):\n" }
{
    printf "%d. %s - %d - %s\n", NR, $2, $1, $3
}
'
