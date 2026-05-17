#!/bin/bash
tail -f /var/log/auth.log | while read line; do
    if echo "$line" | grep -q "Accepted password"; then
        notify-send "Authentication" "User logged in via GUI"
    fi
done
