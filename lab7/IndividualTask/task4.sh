#!/bin/bash
# task4.sh
# Анализирует лог-файл (/var/log/syslog) и выводит:
# - список уникальных сообщений об ошибках (содержащих "error")
# - количество повторений каждого
# - топ-5 самых частых ошибок
# - сохраняет отчёт в файл с датой

MODULE_NAME=$(basename "$0")
LOG_FILE="/var/log/syslog"

# Проверка существования лог-файла
if [ ! -f "$LOG_FILE" ]; then
    echo "$MODULE_NAME : log file not found: $LOG_FILE" >&2
    exit 1
fi

# Формируем имя файла отчёта
REPORT_FILE="error_report_$(date +%Y%m%d_%H%M%S).txt"

echo "Analyzing $LOG_FILE..."
echo "Report will be saved to: $REPORT_FILE"
echo ""

# Анализ ошибок
{
    echo "========================================="
    echo "Error Analysis Report"
    echo "Date: $(date)"
    echo "Log file: $LOG_FILE"
    echo "========================================="
    echo ""
    
    echo "TOP 5 MOST FREQUENT ERRORS:"
    echo "-----------------------------------------"
    
    # Извлекаем строки с error, извлекаем сообщение, считаем частоту
    grep -i "error" "$LOG_FILE" 2>/dev/null | \
        sed 's/^.* error: //I' | \
        sed 's/^.*ERROR: //I' | \
        sed 's/^.*error //I' | \
        sort | \
        uniq -c | \
        sort -rn | \
        head -5 | \
        awk '{printf "%s: %d times\n", substr($0, index($0,$2)), $1}'
    
    echo ""
    echo "-----------------------------------------"
    echo "All unique errors with counts:"
    echo "-----------------------------------------"
    
    # Полный список всех ошибок
    grep -i "error" "$LOG_FILE" 2>/dev/null | \
        sed 's/^.* error: //I' | \
        sed 's/^.*ERROR: //I' | \
        sort | \
        uniq -c | \
        sort -rn | \
        awk '{printf "%s: %d times\n", substr($0, index($0,$2)), $1}'
    
    echo ""
    echo "-----------------------------------------"
    echo "Total error lines: $(grep -ci "error" "$LOG_FILE" 2>/dev/null)"
    echo "========================================="
    
} > "$REPORT_FILE"

# Выводим топ-5 на экран
echo "=== TOP 5 ERRORS ==="
grep -i "error" "$LOG_FILE" 2>/dev/null | \
    sed 's/^.* error: //I' | \
    sed 's/^.*ERROR: //I' | \
    sort | \
    uniq -c | \
    sort -rn | \
    head -5 | \
    awk '{printf "%s: %d times\n", substr($0, index($0,$2)), $1}'

echo ""
echo "Full report saved to: $REPORT_FILE"
