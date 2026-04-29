#! /bin/bash

BACKUP_FILE=".rename_backup_$(date +%s).txt"

# ======== Functions ========

contains_date() {
	local filename="$1"

	if [[ "$filename" =~ _[0-9]{8}(\.|$) ]]; then
		return 0
	else
		return 1
	fi
}

add_date_to_name() {
	local file="$1"
	local dir=$(dirname "$file")
	local base=$(basename "$file")

	if contains_date "$base"; then
		echo "Date exists: $base" >&2
		return 1
	fi

	local mod_date=$(stat -c %Y "$file" 2>/dev/null | date +%Y.%m.%d)

	local name="${base%.*}"
	local ext="${base##*.}"

	if [ "$name" = "$base" ]; then
		local new_name="${name}_${mode_date}"
	else
		local new_name="${name}_${mod_date}.${ext}"
	fi

	echo "$new_name"
}

rollback() {
	echo -e "\n\nReversing..."

	if [ ! -f "$BACKUP_FILE"]; then
		echo "Backup doesn't exist. Restoring nothing."
		exit 1
	fi

	echo "Restoring names..."

	while IFS='|' read -r original new || [ -n "$original" ]; do
		if [ -n "$original" ] && [ -n "$new" ]; then
			if [ -f "$new" ]; then
				mv -v "$new" "$original" 2>/dev/null || echo "Error restoring: $new"
			else
				echo "No file."
			fi
		fi
	done < "$BACKUP_FILE"

	rm -f "$BACKUP_FILE"
	echo "Restoration successfull."
	exit 1
}

# =================== Main ==================

if [ $# -ne 1 ]; then
	echo "Using: $0 <dir>"
	exit 1
fi

TARGET_DIR="$1"

if [ ! -d "$TARGET_DIR" ]; then
	echo "Error: Selected dir does not exist or not a dir."
	exit 1
fi

cd "$TARGET_DIR"

trap rollback SIGINT

> "$BACKUP_FILE"

renamed=0
skipped=0

for file in *; do
	[ -f "$file" ] || continue

	new_name=$(add_date_to_name "$file")

	if [ -n "$new_name" ] && [ "$new_name" != "$file" ]; then
		if mv "$file" "$new_name" 2>/dev/null; then
			echo "File renamed."
			echo "$file|$new_name" >> "$BACKUP_FILE"
			((renamed++))
		else
			echo "Error renaming."
		fi
	else
		((skipped++))
	fi
done

echo -e "\n===Done==="
echo "Files renamed: $renamed"
echo "Files skipped: $skipped"
echo "Backup: $BACKUP_FILE"

trap - SIGINT

exit 0
