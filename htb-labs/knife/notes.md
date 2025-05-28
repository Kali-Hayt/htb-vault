## 🧠 Observations

- [ ] Check if PHP shell upload or RCE is possible
- [ ] Possible PHP vulnerability (Knife often has a Chef or `knife.rb` clue)
- [ ] Try LFI / Command Injection on exposed endpoints

---

## 🧪 Exploitation Path (TBD)

- [ ] Use `curl` or browser to interact with discovered endpoints
- [ ] Try uploading PHP reverse shell if upload functionality found
- [ ] Use `rlwrap nc -lvnp 4444` to catch shells

---

## 🛠️ Post-Exploitation Checklist

- [ ] `whoami`, `hostname`, `ip a`
- [ ] Enumerate sudo permissions: `sudo -l`
- [ ] Look for SUID/cronjobs/misconfigured binaries
- [ ] Capture `user.txt` and `root.txt`

---

## 🧼 Cleanup

- [ ] Remove uploaded shells
- [ ] Clear `.bash_history` if shell was interactive

---

## 🧾 Flags

- [x] `user.txt`: ✅
- [ ] `root.txt`: ⬜

---

## 📌 Notes

- `jq` not installed; use `sudo apt install jq` for JSON FFUF parsing.
- Use `ffuf-to-md.py` (if built) to convert FFUF results to table automatically.

---

## 🔚 Session End

Use `endlog` to commit notes and push to GitHub.
