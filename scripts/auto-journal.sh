#!/bin/bash

TARGET="$1"
if [ -z "$TARGET" ]; then
  echo "Usage: auto-journal.sh <target-ip>"
  exit 1
fi

VAULT="$HOME/Obsidian/hacking-journal"
JOURNAL="$VAULT/daily/$(date +%F).md"
TIMESTAMP=$(date +"%T")
SCAN_TIME=$(date +%H%M)
SCAN_OUTPUT="$VAULT/scans/${TARGET}-nmap-${SCAN_TIME}.txt"

mkdir -p "$(dirname "$JOURNAL")"
mkdir -p "$(dirname "$SCAN_OUTPUT")"

# Create the journal if it doesn't exist
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
- 

## 📋 Commands Run
\`\`\`bash

\`\`\`

## ✅ Learning Detected

## ✅ Results

## 🧠 Lessons Learned

## ❓ Follow-ups

## 🕒 Session Ended
EOF
fi

# Run Nmap scan
echo -e "\n### 🔧 Auto-log @ $TIMESTAMP" >> "$JOURNAL"
echo "nmap -p- -T4 --min-rate=1000 $TARGET" >> "$JOURNAL"

nmap -p- -T4 --min-rate=1000 -oN "$SCAN_OUTPUT" "$TARGET"

# Extract top results from Nmap for Results section
NMAP_SUMMARY=$(grep -E "^[0-9]+/tcp" "$SCAN_OUTPUT" | cut -d' ' -f1,2,3 | head -n 10)

# Append Results, Lessons Learned, Follow-ups
cat <<EOF >> "$JOURNAL"

## ✅ Results
- Nmap scan saved to: $(basename "$SCAN_OUTPUT")
\`\`\`plaintext
$NMAP_SUMMARY
\`\`\`

## 🧠 Lessons Learned
- [ ] Understood tool output
- [ ] Identified key services
- [ ] Learned about new port or protocol

## ❓ Follow-ups
- [ ] Investigate open ports found
- [ ] Try directory fuzzing (gobuster/ffuf)
- [ ] Check for login portals or web services

📚 Reference: [[notes/methodology.md]]
EOF

echo "[✓] HTB log and scan completed for $TARGET"
