#!/bin/bash
# task2.sh
# Напишите сценарий, который создает файл с заданным именем
# и устанавливает для него заданную маску разрешений на доступ.
# После завершения маска возвращается в значение по умолчанию.

MODULE_NAME=$(basename "$0")

# Сохраняем текущую umask
original_umask=$(umask)

read -p "Enter filename to create: " filename
read -p "Enter umask (e.g., 027, 022, 077): " new_umask

# Проверка корректности umask
if ! [[ "$new_umask" =~ ^[0-7]{3}$ ]]; then
    echo "$MODULE_NAME : invalid umask format: $new_umask" >&2
    exit 1
fi

# Устанавливаем новую umask
umask "$new_umask"

# Создаём файл
touch "$filename" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "$MODULE_NAME : cannot create file: $filename" >&2
    umask "$original_umask"
    exit 1
fi

echo "File '$filename' created with umask $new_umask"
echo "Permissions: $(ls -l "$filename" | cut -d' ' -f1)"

# Возвращаем исходную umask
umask "$original_umask"
echo "Default umask restored: $(umask)"
