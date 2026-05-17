#!/bin/bash

# task7_2_1_reliable.sh
# Самый надёжный способ — читать ввод с таймаутом

counter=0
start_time=$(date +%s)

echo "Script started. Press any key then ENTER to exit."
echo "Counter resets every 10 seconds."
echo "---"

while true; do
    echo "Counter: $counter"
    
    # Ждём 2 секунды с возможностью ввода
    read -t 2 -n 1 key
    
    # Если пользователь что-то нажал (включая Ctrl+Z)
    if [ $? -eq 0 ]; then
        echo ""
        echo "Key pressed. Exiting..."
        exit 0
    fi
    
    ((counter++))
    
    current_time=$(date +%s)
    elapsed=$((current_time - start_time))
    
    if [ $elapsed -ge 10 ]; then
        echo ">>> 10 seconds passed, resetting counter to 0 <<<"
        counter=0
        start_time=$(date +%s)
    fi
done
