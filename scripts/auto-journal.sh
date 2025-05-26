#!/bin/bash

BOX="$1"
TARGET="$2"

if [ -z "$BOX" ] || [ -z "$TARGET" ]; then
  echo "Usage: auto-journal.sh <box-name> <target-ip>"
  exit 1
fi

# === Paths ===
VAULT="$HOME/Obsidian/HTB"
BOX_DIR="$VAULT/htb-labs/$BOX"
SCAN_DIR="$BOX_DIR/scans"
SCRIPT_DIR="$BOX_DIR/scripts"
JOURNAL="$VAULT/daily/$(date +%F).md"
TIMESTAMP=$(date +"%T")
SCAN_TIME=$(date +%H%M)
SCAN_OUTPUT="$SCAN_DIR/${TARGET}-nmap-${SCAN_TIME}.txt"

# === Create directories ===
mkdir -p "$SCAN_DIR" "$SCRIPT_DIR"
mkdir -p "$(dirname "$JOURNAL")"

# === Create notes and flags if missing ===
touch "$BOX_DIR/notes.md"
touch "$BOX_DIR/flags.md"

# === Create daily journal if it doesn't exist ===
if [ ! -f "$JOURNAL" ]; then
  cat <<EOF > "$JOURNAL"
## 🧠 Hacking Log - $(date +%F)

## 🗓 Date  
$(date +"%A, %B %d %Y")

## 🕒 Time Started  
$TIMESTAMP

## 🛠 Tools Used  
- 

## 🔍 Target / Lab  
- $BOX ($TARGET)

## 📋 Commands Run
\`\`\`bash

\`\`\`

## ✅ Learning Detected

## ✅ Results

## 🧠 Lessons Learned

## ❓ Follow-ups

## 🕒 Session Ended

📚 Reference: [[notes/methodology.md]]
EOF
fi

# === Run basic nmap scan ===
echo -e "\n### 🔧 Auto-log @ $TIMESTAMP" >> "$JOURNAL"
echo "nmap -p- -T4 -Pn $TARGET" >> "$JOURNAL"
nmap -p- -T4 -Pn -oN "$SCAN_OUTPUT" "$TARGET"

# === Extract top 10 ports from Nmap output ===
NMAP_SUMMARY=$(grep -E "^[0-9]+/tcp" "$SCAN_OUTPUT" | cut -d' ' -f1,2,3 | head -n 10)

# === Append scan results ===
cat <<EOF >> "$JOURNAL"

## ✅ Results
- Nmap scan saved to: $(basename "$SCAN_OUTPUT")
\`\`\`plaintext
$NMAP_SUMMARY
\`\`\`

## 🧠 Lessons Learned
- [ ] Understood Nmap output
- [ ] Identified key services
- [ ] Practiced full port scanning

## ❓ Follow-ups
- [ ] Explore services from top ports
- [ ] Try connecting via browser, curl, or service-specific tool

📚 Reference: [[notes/methodology.md]]
EOF

# === Git sync ===
~/Obsidian/HTB/scripts/gitlog.sh

echo "[✓] HTB log, notes, and scan completed for $BOX ($TARGET)"
