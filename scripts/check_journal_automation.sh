#!/bin/bash

NOTE_PATH=~/ObsidianVault/DailyNotes/$(date +%F).md

declare -A sections=(
  ["🧠 Hacking Log"]="Hacking Log"
  ["🕒 Time Started"]="Time Started"
  ["📋 Commands Run"]="Commands Run"
  ["✅ Learning Detected"]="Learning Detected"
  ["🕒 Session Ended"]="Session Ended"
  ["🛠 Tools Used"]="Tools Used"
  ["🔍 Target / Lab"]="Target / Lab"
  ["✅ Results"]="Results"
  ["🧠 Lessons Learned"]="Lessons Learned"
  ["❓ Follow-ups"]="Follow-ups"
)

echo "🔍 Checking journal automation for: $NOTE_PATH"
echo

for header in "${!sections[@]}"; do
  label="${sections[$header]}"
  if grep -q "### $header" "$NOTE_PATH"; then
    content=$(awk -v h="### $header" '
      $0 ~ h {getline; print}
    ' "$NOTE_PATH" | sed 's/^[[:space:]]*//')
    
    if [[ -n "$content" ]]; then
      echo "✅ $label → Auto-filled"
    else
      echo "⚠️  $label → Header exists, but content is empty"
    fi
  else
    echo "❌ $label → Missing!"
  fi
done
