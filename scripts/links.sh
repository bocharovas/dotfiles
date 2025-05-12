#!/bin/bash
# find_links — lists symlinks and unlinked files separately (with optional color)

# --- Arguments ---
use_color=true
if [[ "$1" == "--color=never" ]]; then
  use_color=false
fi

# --- Colors ---
RED='\033[0;31m'
RESET='\033[0m'
if ! $use_color; then
  RED=''
  RESET=''
fi

# --- Project directories ---
project_root="$(pwd)"
dir1="$project_root/files"
dir2="$project_root/files-crypt"

# --- Temp file to store link targets ---
tempfile=$(mktemp)
trap 'rm -f "$tempfile"' EXIT

# --- Print symlinks ---
echo "=== LINKS TO FILES ==="

find "$HOME" -type l -print0 2>/dev/null | while IFS= read -r -d '' link; do
  target=$(readlink -f "$link")
  if [[ "$target" == "$dir1/"* || "$target" == "$dir2/"* ]]; then
    if [[ -e "$target" ]]; then
      printf '%s -> %s\n' "$link" "$target"
      echo "$target" >> "$tempfile"
    fi
  fi
done

# --- Print unlinked files ---
echo -e "\n=== FILES WITHOUT LINKS ==="

sort -u "$tempfile" -o "$tempfile"

find "$dir1" "$dir2" -type f | while read -r file; do
  if ! grep -Fxq "$file" "$tempfile"; then
    printf '%b%s%b\n' "$RED" "$file" "$RESET"
  fi
done

