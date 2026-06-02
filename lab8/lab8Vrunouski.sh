#!/bin/bash
# Lab 8 — awk, sed, grep, find, tr, wc (Variant 1)
# Usage: ./lab8Vrunouski.sh
# Records session to tasklog1Vrunouski with timelog1Vrunouski

set -uo pipefail
# Allow individual demo commands to fail without aborting the lab run
set +e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

TASKLOG="${SCRIPT_DIR}/tasklog1Vrunouski"
TIMELOG="${SCRIPT_DIR}/timelog1Vrunouski"
BIRTH_MONTH="June"
BIRTH_MONTH_RU="июн"
CARS_FILE="${SCRIPT_DIR}/cars.txt"

ensure_cars_txt() {
    if [[ -f "$CARS_FILE" ]]; then
        return 0
    fi
    echo "Creating missing cars.txt (download from Moodle if your course uses another version)"
    cat > "$CARS_FILE" <<'CARS_EOF'
plym fury    1970 73    2500
ford mustang 1969 45    4500
chevy nova   1965 110   3500
fiat 128     1971 46    2000
amc hornet   1972 52    3000
amc gremlin  1972 40    2000
ford pinto   1972 25    3000
plym satellite 1973 46 1900
amc rebel    1971 50   3500
ford granada 1972 25    2000
plym valiant 1973 46    1900
chev vega    1971 60    2000
fiat 124     1973 51    1750
toyota corolla 1975 40  1500
amc pacer    1975 11    1500
plym champ   1975 69    1500
fiat 128     1975 21    1500
datsun 200   1974 40    1750
datsun 210   1974 46    1750
ford mustang 1975 43    1750
plym duster  1975 81    2750
CARS_EOF
    cp "$CARS_FILE" "${SCRIPT_DIR}/2.3/cars.txt"
}

run_inner() {
    ensure_cars_txt

    echo "========== Lab 8 started: $(date) =========="
    echo "Working directory: $SCRIPT_DIR"
    echo "cars.txt: $CARS_FILE ($(wc -l < "$CARS_FILE") lines)"
    echo

    section_2_1
    section_2_2
    section_2_3
    section_2_4

    echo
    echo "========== Lab 8 finished: $(date) =========="
}

section_header() {
    echo
    echo "################################################################"
    echo "# $1"
    echo "################################################################"
    echo
}

section_2_1() {
    section_header "2.1 AWK examples"
    local ex="${SCRIPT_DIR}/2.1/examples"

    echo "--- Example 1: search bash in log.txt ---"
    awk '/bash/ {print}' "${ex}"/*

    echo "--- Example 2: search QUIT|SETDATE in protocols (if exists) ---"
    awk '/QUIT|SETDATE/' /usr/include/protocols/* 2>/dev/null | head -5 || echo "(no matches or path unavailable)"

    echo "--- Example 3: print fields from myfile ---"
    awk '{print $1}' "${ex}/myfile"
    awk '{print $3}' "${ex}/myfile"

    echo "--- Example 5: surname, name, rating ---"
    awk '{print $1, $2, $5}' "${ex}/list_students"

    echo "--- Example 6: rating 8 ---"
    awk '/8/ {print $0}' "${ex}/list_students"

    echo "--- Example 7: rating == 4 ---"
    awk '($5 == 4)' "${ex}/list_students"

    echo "--- Example 8: faculty KB, course 1 ---"
    awk '($3 == "КБ") && ($4 == 1)' "${ex}/list_students"

    echo "--- Example 9: name length > 5 ---"
    awk '(length($2) > 5) {print}' "${ex}/list_students"

    echo "--- Example 10: numbered table ---"
    awk '{print NR, $0}' "${ex}/list_students"

    echo "--- Example 11: uppercase names ---"
    awk '{print toupper($2)}' "${ex}/list_students"

    echo "--- Example 12: sum of ratings ---"
    awk '{sum += $5} END {print "SUM=", sum}' "${ex}/list_students"

    echo "--- Example 13: Kравченя ---"
    awk '($1 ~ /Кравченя/)' "${ex}/list_students"

    echo "--- Example 14: Lipin (any case) ---"
    awk '($1 ~ /[Лл]ипин/)' "${ex}/list_students"

    echo "--- Example 15: colours.csv amount > 6 ---"
    awk -F',' '$3 > 6 {print $1, $2}' "${ex}/colours.csv"
}

section_2_2() {
    section_header "2.2 SED examples"
    local d="${SCRIPT_DIR}/2.2"

    echo "--- sed '/book/ p' (duplicate matching lines) ---"
    sed '/book/ p' "${d}/books" | head -20

    echo "--- sed -n '/book/ p' ---"
    sed -n '/book/ p' "${d}/books"

    echo "--- sed -n '2,5 p' ---"
    sed -n '2,5 p' "${d}/books"

    echo "--- sed -n -f records ---"
    sed -n -f "${d}/records" "${d}/books"

    echo "--- sed -f appends ---"
    sed -f "${d}/appends" "${d}/books"

    echo "--- sed -f insert ---"
    sed -f "${d}/insert" "${d}/books"

    echo "--- sed -n 's/book/novel/ p' ---"
    sed -n 's/book/novel/ p' "${d}/books"
}

section_2_3() {
    section_header "2.3 AWK and SED — Variant 1"
    local d="${SCRIPT_DIR}/2.3"

    echo "--- General: network interfaces (ip + awk + /sys), exclude lo ---"
    chmod +x "${d}/network_interfaces.sh"
    "${d}/network_interfaces.sh"

    echo "--- Task 1: even lines of cars.txt, manufacturer uppercase ---"
    echo "Input: $CARS_FILE"
    awk -f "${d}/task1_cars_even.awk" "$CARS_FILE"

    echo "--- Task 2: rectangle area and perimeter ---"
    awk -f "${d}/rectangle.awk"

    echo "--- Task 3: replace second comma with | ---"
    echo "Original:"
    cat "${d}/comma_data.txt"
    echo "After sed:"
    sed 's/\([^,]*\),\([^,]*\),/\1,\2|/' "${d}/comma_data.txt"
}

section_2_4() {
    section_header "2.4 grep, find, tr, wc"
    local g="${SCRIPT_DIR}/2.4"
    local grep_dir="${g}/grep"
    mkdir -p "$grep_dir"

    echo "--- grep 1-4: dirlist and month filter ($BIRTH_MONTH) ---"
    cat > "${g}/dirlist.txt" <<'EOF'
January report archive
February backup old
March notes draft
April meeting notes
May project files
June vacation photos
July summer trip
August school start
September autumn
October harvest
November prep
December holidays
random_file_june_extra
EOF

    grep -i "$BIRTH_MONTH" "${g}/dirlist.txt" > "${g}/grep_month_name.txt"
    grep -vi "$BIRTH_MONTH" "${g}/dirlist.txt" > "${g}/grep_other_monthes.txt"
    cp "${g}/dirlist.txt" "${grep_dir}/"
    cp "${g}/grep_month_name.txt" "${grep_dir}/"
    cp "${g}/grep_other_monthes.txt" "${grep_dir}/"
    echo "grep_month_name.txt:"; cat "${g}/grep_month_name.txt"
    echo "grep_other_monthes.txt:"; cat "${g}/grep_other_monthes.txt"

    echo "--- grep 5: mac_os_lab search root ---"
    local mac="${g}/mac_os_lab"
    mkdir -p "${mac}/level1/level2/level3" "${mac}/a/b/c" "${mac}/docs/sys"
    echo "root config" > "${mac}/level1/root_cfg.txt"
    echo "user data" > "${mac}/level1/level2/user.txt"
    echo "system root access" > "${mac}/level1/level2/level3/deep_root.txt"
    echo "plain file" > "${mac}/a/b/c/plain.txt"
    echo "root daemon" > "${mac}/docs/sys/root.txt"
    (cd "$mac" && grep -rn --include='*' 'root' . || true)

    echo "--- grep 6: lowercase words and words with digits ---"
    grep -oE '[a-z]+' "${g}/dirlist.txt" | sort -u > "${g}/grep_lowercase_words.txt"
    grep -oE '[a-zA-Z]*[0-9][a-zA-Z0-9]*' "${g}/dirlist.txt" > "${g}/grep_words_with_digits.txt" || true
    cat "${g}/grep_lowercase_words.txt"

    echo "--- grep 7: config in /etc (limited) ---"
    grep -r --include='*.txt' --include='*.conf' --include='*.yaml' -l 'config' /etc 2>/dev/null | head -10 || echo "(limited by permissions)"

    echo "--- grep 8: warning in /var/log excluding .tmp/.old ---"
    grep -r --exclude='*.tmp' --exclude='*.old' -i 'warning' /var/log 2>/dev/null | head -5 || echo "(no matches or permission denied)"

    echo "--- grep 9: Kernel in /var/log with line numbers ---"
    grep -rn 'Kernel' /var/log 2>/dev/null | head -5 || echo "(no matches)"

    echo "--- grep 10: pattern count ---"
    cat > "${g}/pattern_file.txt" <<'EOF'
line without
pattern here once
another line
pattern twice pattern
no match
pattern at end
middle pattern word
EOF
    echo "Count only:"; grep -c 'pattern' "${g}/pattern_file.txt"
    echo "With lines:"; grep 'pattern' "${g}/pattern_file.txt"

    echo "--- find 11: bash in name (find vs locate) ---"
    echo "find (first 10):"; time find /usr -name '*bash*' 2>/dev/null | head -10
    if command -v locate >/dev/null 2>&1; then
        echo "locate (first 10):"; time locate '*bash*' 2>/dev/null | head -10
    else
        echo "locate: not installed (find scans live; locate uses DB — faster when DB exists)"
    fi

    echo "--- find 12: .txt in current tree ---"
    find "$SCRIPT_DIR" -name '*.txt' 2>/dev/null | head -15

    echo "--- find 13: symlinks in / (maxdepth 1) ---"
    find / -maxdepth 1 -type l -ls 2>/dev/null

    echo "--- find 14: /var/log modified last 7 days ---"
    find /var/log -type f -mtime -7 2>/dev/null | head -10

    echo "--- find 15: delete old files in lab tmp_demo (safe substitute for /tmp) ---"
    local demo_tmp="${g}/tmp_demo"
    mkdir -p "$demo_tmp"
    touch -d '40 days ago' "${demo_tmp}/old_file.txt"
    touch "${demo_tmp}/new_file.txt"
    echo "Before:"; ls -la "$demo_tmp"
    find "$demo_tmp" -type f -mtime +30 -print -delete
    echo "After:"; ls -la "$demo_tmp"

    echo "--- find 16: permission 777 in /home ---"
    find /home -type f -perm 777 2>/dev/null | head -5 || echo "(none found)"

    echo "--- find 17: files owned by student ---"
    find /home -user student 2>/dev/null | head -5 || echo "(user student not found or no files)"

    echo "--- find 18: files >100MB in /var ---"
    find /var -type f -size +100M -printf '%s %p\n' 2>/dev/null | head -5 || echo "(none or permission denied)"

    echo "--- find 19 + grep: error in .log and .tmp under /var ---"
    find /var \( -name '*.log' -o -name '*.tmp' \) -exec grep -l 'error' {} + 2>/dev/null | head -5 || echo "(no matches)"

    echo "--- find 20-21: encodings and search Текст ---"
    setup_encoding_files
    echo "UTF-8:"; find "${g}/encodings" -name '*.utf8' -exec grep -a 'Текст' {} + 2>/dev/null || true
    echo "CP1251:"; find "${g}/encodings" -name '*.cp1251' -exec grep -a 'Текст' {} + 2>/dev/null || true
    echo "KOI8-R:"; find "${g}/encodings" -name '*.koi8' -exec grep -a 'Текст' {} + 2>/dev/null || true
    chmod +x "${g}/search_text_encodings.sh"
    "${g}/search_text_encodings.sh"

    echo "--- tr 22-24 ---"
    cat > "${g}/zadacha40.txt" <<'EOF'
linux is my life
linux has changed my life
linux is best and everthing to me..:)
EOF
    cat "${g}/zadacha40.txt" | tr 'a-z' 'A-Z' > "${g}/output41_pipe.txt"
    tr 'a-z' 'A-Z' < "${g}/zadacha40.txt" > "${g}/output41_redirect.txt"
    echo "the linux staff" | tr -d 't'
    echo "output41_pipe.txt:"; cat "${g}/output41_pipe.txt"

    echo "--- wc 25-31 ---"
    cat > "${g}/linux_os.txt" <<'EOF'
Red Hat
CentOS
Fedora
Debian
Scientific Linux
OpenSuse
Ubuntu
Xubuntu
Linux Mint
Pearl Linux
Slackware
Mandriva
EOF
    wc "${g}/linux_os.txt"
    wc -l "${g}/linux_os.txt"
    wc -w "${g}/linux_os.txt"
    awk '{ if (length($0) > m) m = length($0) } END { print m }' "${g}/linux_os.txt"
    wc -m "${g}/linux_os.txt"
    echo "Files in HOME:"; ls "$HOME" 2>/dev/null | wc -l

    prepare_wc_input_files "${g}"
}

setup_encoding_files() {
    local enc="${SCRIPT_DIR}/2.4/encodings"
    local text_utf8="Текст в UTF-8"
    local text_plain="Sample line without keyword"
    mkdir -p "${enc}/root/sub" "${enc}/nested/deep"

    echo "$text_utf8" > "${enc}/file1.utf8"
    echo "$text_plain" > "${enc}/file2.utf8"
    echo "$text_utf8" > "${enc}/root/file3.utf8"
    echo "$text_plain" > "${enc}/nested/file4.utf8"
    echo "$text_utf8" > "${enc}/nested/deep/file5.utf8"
    echo "$text_plain" > "${enc}/nested/deep/file6.utf8"

    for base in root sub; do
        echo "$text_utf8" | iconv -f UTF-8 -t CP1251 > "${enc}/${base}/cp1.cp1251"
        echo "$text_plain" | iconv -f UTF-8 -t CP1251 > "${enc}/${base}/cp2.cp1251"
        echo "$text_utf8" | iconv -f UTF-8 -t KOI8-R > "${enc}/${base}/koi1.koi8"
        echo "$text_plain" | iconv -f UTF-8 -t KOI8-R > "${enc}/${base}/koi2.koi8"
    done
}

prepare_wc_input_files() {
    local g="$1"
    seq 30 | while read -r n; do echo "line $n sample text"; done > "${g}/input_lower.txt"
    tr 'a-z' 'A-Z' < "${g}/input_lower.txt" | tee "${g}/input_upper.txt" | wc -w

    seq 30 | while read -r n; do echo "word${n}    extra   spaces"; done > "${g}/input_spaces.txt"
    tr -s ' ' < "${g}/input_spaces.txt" > "${g}/input_spaces_fixed.txt"
    wc -l "${g}/input_spaces_fixed.txt"

    seq 30 | while read -r n; do echo "line:$n:data:$n:end"; done > "${g}/input_colons.txt"
    tr ':' '-' < "${g}/input_colons.txt" > "${g}/input_colons_fixed.txt"
    wc -c "${g}/input_colons_fixed.txt"

    seq 30 | while read -r n; do echo "item${n} code${n} end"; done > "${g}/input_digits.txt"
    tr -d '0-9' < "${g}/input_digits.txt" > "${g}/input_digits_fixed.txt"
    wc -w "${g}/input_digits_fixed.txt"

    seq 30 | while read -r n; do echo "aaabbbccc line $n"; done > "${g}/input_repeat.txt"
    tr -s 'a-z' < "${g}/input_repeat.txt" > "${g}/input_repeat_fixed.txt"
    sort -u "${g}/input_repeat_fixed.txt" | wc -l
}

# Write standalone search script for task 21
write_search_script() {
    cat > "${SCRIPT_DIR}/2.4/search_text_encodings.sh" <<'SEARCH_EOF'
#!/bin/bash
ENC_DIR="$(cd "$(dirname "$0")/encodings" && pwd)"
find "$ENC_DIR" -type f | while read -r f; do
    case "$f" in
        *.utf8) enc_from="UTF-8" ;;
        *.cp1251) enc_from="CP1251" ;;
        *.koi8) enc_from="KOI8-R" ;;
        *) continue ;;
    esac
    if iconv -f "$enc_from" -t UTF-8 "$f" 2>/dev/null | grep -q 'Текст'; then
        echo "FOUND [$enc_from]: $f"
    fi
done
SEARCH_EOF
    chmod +x "${SCRIPT_DIR}/2.4/search_text_encodings.sh"
}

write_search_script

if [[ -z "${LAB8_INNER:-}" ]]; then
    export LAB8_INNER=1
    echo "Starting script session -> $TASKLOG (timelog: $TIMELOG)"
    script -T "$TIMELOG" -O "$TASKLOG" -f -c "LAB8_INNER=1 bash '$SCRIPT_DIR/lab8Vrunouski.sh'"
else
    run_inner
fi