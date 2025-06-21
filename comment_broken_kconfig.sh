#!/bin/bash

TARGET="security/Kconfig.hardening"
BACKUP="$TARGET.bak"
LOG_FILE="kconfig_mass_comment.log"

echo "[INFO] Mass-commenting $TARGET at $(date)" | tee "$LOG_FILE"

if [[ -f "$TARGET" ]]; then
  echo "[*] Backing up original to $BACKUP" | tee -a "$LOG_FILE"
  cp "$TARGET" "$BACKUP"

  echo "[*] Commenting every line in $TARGET" | tee -a "$LOG_FILE"
  sed -i '' -e 's/^/# [DISABLED] /' "$TARGET"

  echo "[✓] File commented successfully" | tee -a "$LOG_FILE"
else
  echo "[✗] File not found: $TARGET" | tee -a "$LOG_FILE"
fi

echo "[✔] Done at $(date)" | tee -a "$LOG_FILE"

