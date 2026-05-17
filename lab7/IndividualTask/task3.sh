#!/bin/bash
# task3.sh
# Написать сценарий для поиска файлов заданного размера
# в заданном каталоге и во всех его подкаталогах.
# Диапазон (мин.–макс.) размеров задаётся первыми двумя аргументами.
# Имя каталога — третий аргумент.

MODULE_NAME=$(basename "$0")

# Проверка количества аргументов
if [ $# -ne 3 ]; then
    echo "$MODULE_NAME : usage: $0 min_size max_size directory" >&2
    echo "Example: $0 1000 1510 /usr" >&2
    exit 1
fi

min_size=$1
max_size=$2
search_dir=$3

# Проверка, что размеры — числа
if ! [[ "$min_size" =~ ^[0-9]+$ ]] || ! [[ "$max_size" =~ ^[0-9]+$ ]]; then
    echo "$MODULE_NAME : min and max sizes must be numbers" >&2
    exit 1
fi

# Проверка существования каталога
if [ ! -d "$search_dir" ]; then
    echo "$MODULE_NAME : directory not found: $search_dir" >&2
    exit 1
fi

echo "Searching in $search_dir for files with size between $min_size and $max_size bytes..."
echo ""

found_count=0

# Поиск файлов
while IFS= read -r file; do
    if [ -f "$file" ]; then
        size=$(stat -c%s "$file" 2>/dev/null)
        if [ -n "$size" ] && [ "$size" -ge "$min_size" ] && [ "$size" -le "$max_size" ]; then
            echo "$file : $size bytes"
            ((found_count++))
        fi
    fi
done < <(find "$search_dir" -type f 2>/dev/null)

echo ""
echo "Total files found: $found_count"
