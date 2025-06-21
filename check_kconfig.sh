#!/bin/bash

LOG_FILE="kconfig_check.log"
echo "[INFO] Kconfig syntax check started at $(date)" | tee "$LOG_FILE"
echo "[INFO] Scanning for invalid characters: \$ , (excluding comments)" | tee -a "$LOG_FILE"

# Track if issues were found
found=0

# Scan all Kconfig* files
find . -name "Kconfig*" | while read -r file; do
  echo "[*] Checking $file" | tee -a "$LOG_FILE"
  matches=$(grep -n '[\$,]' "$file" | grep -vE '^\s*#')

  if [[ -n "$matches" ]]; then
    echo "$matches" | tee -a "$LOG_FILE"
    found=1
  fi
done

if [[ $found -eq 1 ]]; then
  echo "[✗] Kconfig issues found. Review $LOG_FILE for details." | tee -a "$LOG_FILE"
else
  echo "[✓] No invalid syntax found in any Kconfig file." | tee -a "$LOG_FILE"
fi

echo "[✔] Kconfig syntax check completed at $(date)" | tee -a "$LOG_FILE"

