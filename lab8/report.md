# Отчёт по лабораторной работе №8

## Инструментальные средства обработки текстовых данных (awk, sed, grep, find, tr, wc)

**Вариант:** №1

**Выполнил:** Вруновский Константин Андреевич

**Каталог работы:** `linux-labs2026-KonstantinVrunouski/lab8/`

---

## Оглавление

1. [Цель работы](#цель-работы)
2. [Протоколирование](#протоколирование)
3. [Задание 2.1 — примеры awk](#задание-21--примеры-awk)
4. [Задание 2.2 — примеры sed](#задание-22--примеры-sed)
5. [Задание 2.3 — вариант 1](#задание-23--вариант-1)
6. [Задание 2.4 — grep, find, tr, wc](#задание-24--grep-find-tr-wc)

---

## Цель работы

Изучить утилиты обработки текстовых данных **awk** и **sed**, а также применить **grep**, **find**, **tr** и **wc** для фильтрации, поиска и преобразования файлов в ОС Linux.

---

## Протоколирование

Перед выполнением заданий включена запись протокола командой `script` с журналом меток времени:

- `tasklog1Vrunouski` — протокол команд;
- `timelog1Vrunouski` — журнал меток времени.

![Протоколирование](screens/00-protokol.png)

---

## Задание 2.1 — примеры awk

Подготовлен каталог `2.1/examples/` с файлами `log.txt`, `myfile`, `list_students`, `colours.csv`.

### Пример 1 — поиск bash в log.txt

![Пример 1](screens/2.1-01-bash.png)

### Пример 3 — вывод первого поля

![Пример 3](screens/2.1-03-pole1.png)

### Пример 5 — фамилия, имя, оценка

![Пример 5](screens/2.1-05-students.png)

### Пример 7 — студенты с оценкой 4

![Пример 7](screens/2.1-07-ocenka4.png)

### Пример 10 — нумерация строк

![Пример 10](screens/2.1-10-nr.png)

### Пример 12 — сумма оценок

![Пример 12](screens/2.1-12-sum.png)

### Пример 15 — colours.csv, amount > 6

![Пример 15](screens/2.1-15-csv.png)

---

## Задание 2.2 — примеры sed

Создан файл `2.2/books`, файлы `records`, `appends`, `insert`.

### Пример 2 — дублирование строк с book

![Пример 2](screens/2.2-02-dup.png)

### Пример 3 — только строки с book

![Пример 3](screens/2.2-03-print.png)

### Пример 4 — строки 2–5

![Пример 4](screens/2.2-04-range.png)

### Пример 5 — команды из файла records

![Пример 5](screens/2.2-05-records.png)

### Пример 6 — добавление строки после 3-й

![Пример 6](screens/2.2-06-append.png)

### Пример 7 — вставка SKARBONKA

![Пример 7](screens/2.2-07-insert.png)

### Пример 8 — замена book на novel

![Пример 8](screens/2.2-08-replace.png)

---

## Задание 2.3 — вариант 1

### Общее задание — сетевые интерфейсы

Скрипт `2.3/network_interfaces.sh` использует `ip`, **awk** и каталог `/sys/class/net/`, исключает `lo`, нумерует вывод.

![Сетевые интерфейсы](screens/2.3-00-interfaces.png)

### Задание 1 — чётные строки cars.txt

Файл `cars.txt` в каталоге `lab8/`. AWK-программа `task1_cars_even.awk` выводит чётные строки; производитель — в верхнем регистре.

![Задание 2.3.1](screens/2.3-01-cars.png)

### Задание 2 — площадь и периметр прямоугольника

`rectangle.awk` — функции `area()`, `perimeter()`, вызов из `main()`.

![Задание 2.3.2](screens/2.3-02-rectangle.png)

### Задание 3 — замена второй запятой на |

Файл `comma_data.txt`, команда **sed** с группами `\([^,]*\)`.

![Задание 2.3.3](screens/2.3-03-comma.png)

---

## Задание 2.4 — grep, find, tr, wc

### grep

#### Задание 1 — файл dirlist.txt

![grep 1](screens/2.4-grep-01-dirlist.png)

#### Задание 2 — строки с месяцем June

![grep 2](screens/2.4-grep-02-month.png)

#### Задание 3 — строки без June

![grep 3](screens/2.4-grep-03-other.png)

#### Задание 4 — каталог grep/

![grep 4](screens/2.4-grep-04-folder.png)

#### Задание 5 — поиск root в mac_os_lab

![grep 5](screens/2.4-grep-05-root.png)

#### Задание 6 — слова из строчных букв

![grep 6](screens/2.4-grep-06-classes.png)

#### Задание 7 — config в /etc

![grep 7](screens/2.4-grep-07-config.png)

#### Задание 8 — warning в /var/log

![grep 8](screens/2.4-grep-08-warning.png)

#### Задание 9 — Kernel с номерами строк

![grep 9](screens/2.4-grep-09-kernel.png)

#### Задание 10 — подсчёт pattern

![grep 10](screens/2.4-grep-10-pattern.png)

### find

#### Задание 11 — файлы *bash*

![find 11](screens/2.4-find-11-bash.png)

#### Задание 12 — .txt в lab8

![find 12](screens/2.4-find-12-txt.png)

#### Задание 13 — символические ссылки в /

![find 13](screens/2.4-find-13-symlinks.png)

#### Задание 14 — /var/log за 7 дней

![find 14](screens/2.4-find-14-log7.png)

#### Задание 15 — удаление старых файлов (tmp_demo)

![find 15](screens/2.4-find-15-tmp.png)

#### Задание 16 — права 777 в /home

![find 16](screens/2.4-find-16-777.png)

#### Задание 17 — файлы пользователя student

![find 17](screens/2.4-find-17-student.png)

#### Задание 18 — файлы >100 МБ в /var

![find 18](screens/2.4-find-18-100m.png)

#### Задание 19 — error в .log

![find 19](screens/2.4-find-19-error.png)

#### Задания 20–21 — поиск «Текст» в кодировках

![find 20–21](screens/2.4-find-20-21-encoding.png)

### tr

#### Задание 22 — cat | tr

![tr 22](screens/2.4-tr-22.png)

#### Задание 23 — tr с перенаправлением <

![tr 23](screens/2.4-tr-23.png)

#### Задание 24 — удаление буквы t

![tr 24](screens/2.4-tr-24.png)

### wc

#### Задание 25 — wc для linux_os.txt

![wc 25](screens/2.4-wc-25.png)

#### Задание 26 — число файлов в HOME

![wc 26](screens/2.4-wc-26.png)

#### Задание 27 — слова после upper

![wc 27](screens/2.4-wc-27.png)

#### Задание 28 — строки после сжатия пробелов

![wc 28](screens/2.4-wc-28.png)

#### Задание 29 — байты после замены :

![wc 29](screens/2.4-wc-29.png)

#### Задание 30 — слова без цифр

![wc 30](screens/2.4-wc-30.png)

#### Задание 31 — уникальные строки

![wc 31](screens/2.4-wc-31.png)

---
