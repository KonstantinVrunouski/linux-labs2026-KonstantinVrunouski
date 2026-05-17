#!/bin/bash
for f in *.jpeg; do
    mv "$f" "new_$f"
done
