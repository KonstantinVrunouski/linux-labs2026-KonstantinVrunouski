#!/bin/bash
# Assignment 2.3 (general): list network interfaces using ip, awk and /sys
# Excludes loopback (lo). Output is numbered.

ip -o link show | awk '
BEGIN { n = 0 }
{
    iface = $2
    sub(/:$/, "", iface)
    if (iface == "lo") next

    alt = "-"
    for (i = 1; i <= NF; i++) {
        if ($i == "altname" && (i + 1) <= NF) {
            alt = $(i + 1)
        }
    }

    n++
    printf "%d. interface=%s altname=%s sysfs=/sys/class/net/%s\n", n, iface, alt, iface
}
'