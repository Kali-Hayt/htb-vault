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

# === Create daily journal ===
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
- $BOX - $TARGET

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

# === Run Nmap scan ===
echo -e "\n### 🔧 Auto-log @ $TIMESTAMP" >> "$JOURNAL"
echo "nmap -p- -T4 --min-rate=1000 $TARGET" >> "$JOURNAL"

nmap -p- -T4 --min-rate=1000 -oN "$SCAN_OUTPUT" "$TARGET"

# === Parse top ports from scan ===
NMAP_SUMMARY=$(grep -E "^[0-9]+/tcp" "$SCAN_OUTPUT" | cut -d' ' -f1,2,3 | head -n 10)

# === Parse open ports from scan for -sV ===
OPEN_PORTS=$(grep -Eo '^[0-9]+/tcp' "$SCAN_OUTPUT" | cut -d'/' -f1 | paste -sd, -)

# === Run -sV scan on open ports ===
if [ -n "$OPEN_PORTS" ]; then
  VERSION_SCAN="$BOX_DIR/scans/${TARGET}-nmap-services-${SCAN_TIME}.txt"
  echo "[+] Detected open ports: $OPEN_PORTS"
  echo "[+] Running service/version detection..."

  nmap -sV -p"$OPEN_PORTS" -oN "$VERSION_SCAN" "$TARGET"

  # Log into journal
  echo -e "\n## 🔎 Version Scan Results (Top Ports)" >> "$JOURNAL"
  echo "- Saved to: $(basename "$VERSION_SCAN")" >> "$JOURNAL"
  echo "\`\`\`plaintext" >> "$JOURNAL"
  grep -E "^[0-9]+/tcp" "$VERSION_SCAN" | head -n 10 >> "$JOURNAL"
  echo "\`\`\`" >> "$JOURNAL"
else
  echo "[!] No open ports found — skipping version scan."
  echo "- No open ports found. Skipped service scan." >> "$JOURNAL"
fi


# === Append results to journal ===
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

# === Auto Git push ===
"$VAULT/scripts/gitlog.sh"

echo "[✓] HTB log, notes, and scan completed for $BOX ($TARGET)"
