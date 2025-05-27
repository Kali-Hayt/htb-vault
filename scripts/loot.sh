#!/bin/bash

BOX_NAME="$1"
if [ -z "$BOX_NAME" ]; then
  echo "Usage: loot.sh <box-name>"
  exit 1
fi

VAULT="$HOME/Obsidian/HTB"
BOX_DIR="$VAULT/htb-labs/$BOX_NAME"
LOOT_DIR="$BOX_DIR/loot"

mkdir -p "$LOOT_DIR"

echo "[+] Copying loot into: $LOOT_DIR"

cp ~/.ssh/id_rsa* "$LOOT_DIR/" 2>/dev/null
cp ~/.bash_history "$LOOT_DIR/" 2>/dev/null
cp /etc/passwd "$LOOT_DIR/" 2>/dev/null
cp /etc/shadow "$LOOT_DIR/" 2>/dev/null
cp /root/.bash_history "$LOOT_DIR/" 2>/dev/null
cp /var/www/html/config.php "$LOOT_DIR/" 2>/dev/null

echo "[✓] Loot collection attempted. Check $LOOT_DIR"
