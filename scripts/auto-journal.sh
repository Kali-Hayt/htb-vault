#!/bin/bash

BOX="$1"
TARGET="$2"

if [ -z "$BOX" ] || [ -z "$TARGET" ]; then
  echo "Usage: auto-journal.sh <box-name> <target-ip>"
  exit 1
fi

VAULT="$HOME/Obsidian/HTB"
BOX_DIR="$VAULT/htb-labs/$BOX"
SCAN_DIR="$BOX_DIR/scans"
SCRIPT_DIR="$BOX_DIR/scripts"
JOURNAL="$VAULT/daily/$(date +%F).md"
TIMESTAMP=$(date +"%T")
SCAN_TIME=$(date +%H%M)
SCAN_OUTPUT="$SCAN_DIR/${TARGET}-nmap-${SCAN_TIME}.txt"
FLAG_FILE="$BOX_DIR/flag.txt"
NOTES_FILE="$BOX_DIR/notes.md"
FLAGS_MD="$BOX_DIR/flags.md"

mkdir -p "$SCAN_DIR" "$SCRIPT_DIR"
mkdir -p "$(dirname "$JOURNAL")"

touch "$NOTES_FILE"
touch "$FLAGS_MD"

nmap -p- -T4 -Pn -oN "$SCAN_OUTPUT" "$TARGET"

NMAP_SERVICES=$(grep -E "^[0-9]+/tcp" "$SCAN_OUTPUT")
NMAP_SUMMARY=$(echo "$NMAP_SERVICES" | cut -d' ' -f1,2,3 | head -n 10)

TOOLS="- nmap"
COMMANDS="nmap -p- -T4 -Pn $TARGET"
LEARNINGS=""
LESSONS=""
FOLLOWUPS=""
RESULTS=""
FLAG="HTB{REPLACE_WITH_YOUR_FLAG}"

if echo "$NMAP_SERVICES" | grep -q "23/tcp"; then
  TOOLS="$TOOLS
- telnet"
  COMMANDS="$COMMANDS
telnet $TARGET
cat /root/flag.txt"
  LEARNINGS="- Telnet (port 23) was open and allowed unauthenticated access"
  LESSONS="- Telnet is insecure due to lack of encryption"
  FOLLOWUPS="- [ ] Create a detection rule for open Telnet ports"
  RESULTS="- Telnet access confirmed"
fi

if [ -f "$FLAG_FILE" ]; then
  FLAG=$(grep -o 'HTB{[^}]*}' "$FLAG_FILE")
  echo -e "## $(date +%F)
$FLAG" >> "$FLAGS_MD"
fi

cat <<EOF > "$JOURNAL"
## 🧠 Hacking Log - $(date +%F)

## 🗓 Date  
$(date +"%A, %B %d %Y")

## 🕒 Time Started  
$TIMESTAMP

## 🛠 Tools Used  
$TOOLS

## 🔍 Target / Lab  
- $BOX ($TARGET)

## 📋 Commands Run
\`\`\`bash
$COMMANDS
\`\`\`

## ✅ Learning Detected
$LEARNINGS

## ✅ Results
$RESULTS
- Retrieved root flag:
  $FLAG

\`\`\`plaintext
$NMAP_SUMMARY
\`\`\`

## 🧠 Lessons Learned
$LESSONS

## ❓ Follow-ups
$FOLLOWUPS

## 🕒 Session Ended

📚 Reference: [[notes/methodology.md]]
EOF

"$VAULT/scripts/gitlog.sh"

echo "[✓] Journal complete for $BOX ($TARGET)"
