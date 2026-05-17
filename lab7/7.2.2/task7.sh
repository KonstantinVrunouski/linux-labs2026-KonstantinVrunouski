#!/bin/bash
dir=${1:-.}
files=()
while IFS= read -r f; do
    files+=("$f")
done < <(find "$dir" -type f -perm 755)
printf '%s\n' "${files[@]}"
