#!/bin/bash
# task1.sh
# Разработать сценарий, который:
# - запрашивает имя пользователя
# - если не зарегистрирован, повторяет запрос
# - выводит UID, основную группу и все группы (через пробел)

MODULE_NAME=$(basename "$0")

while true; do
    read -p "Enter username: " username
    
    if id "$username" &>/dev/null 2>&1; then
        # Пользователь существует
        uid=$(id -u "$username" 2>/dev/null)
        primary_group=$(id -gn "$username" 2>/dev/null)
        all_groups=$(id -Gn "$username" 2>/dev/null | tr ' ' '\n' | grep -v "^$primary_group$" | tr '\n' ' ')
        
        echo "UID: $uid"
        echo "Primary group: $primary_group"
        echo "All groups: $primary_group $all_groups"
        break
    else
        # Пользователь не существует
        echo "$MODULE_NAME : user not found: $username" >&2
        echo "User '$username' is not registered. Please try again." >&2
        # Продолжаем цикл
    fi
done
