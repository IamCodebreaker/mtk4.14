#!/bin/bash

LOG_FILE="kconfig_auto_fix.log"
echo "[INFO] Starting Kconfig fix at $(date)" | tee "$LOG_FILE"

FILES=(
  "./net/bpfilter/Kconfig"
  "./security/Kconfig.hardening"
)

for file in "${FILES[@]}"; do
  if [[ -f "$file" ]]; then
    echo "[*] Fixing $file" | tee -a "$LOG_FILE"
    cp "$file" "$file.bak"
    sed -i '' -E '/^[[:space:]]*[^#].*[\$,]/s/^/# [AUTO-COMMENTED] /' "$file"
    echo "[✓] Fixed $file (backup saved as $file.bak)" | tee -a "$LOG_FILE"
  else
    echo "[✗] File not found: $file" | tee -a "$LOG_FILE"
  fi
done

echo "[✔] Done fixing Kconfig syntax at $(date)" | tee -a "$LOG_FILE"

