#!/usr/bin/awk -f
# Variant 1, task 1: even lines; manufacturer uppercase only
NR % 2 == 0 {
    print toupper($1), $2, $3, $4, $5
}