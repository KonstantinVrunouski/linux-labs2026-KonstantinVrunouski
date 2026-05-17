#!/bin/bash
for iface in $(ls /sys/class/net/); do
    status=$(cat /sys/class/net/$iface/operstate 2>/dev/null)
    echo "$iface: $status"
done
