#!/bin/bash
for iface in /sys/class/net/*; do
    echo "Interface: $(basename $iface)"
done
