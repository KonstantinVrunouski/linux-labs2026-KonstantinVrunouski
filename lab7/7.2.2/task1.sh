#!/bin/bash
read -p "Enter an integer: " num
if [ $num -gt 0 ]; then
    echo "Positive"
elif [ $num -eq 0 ]; then
    echo "Zero"
else
    echo "Negative"
fi
