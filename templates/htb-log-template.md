## 🧠 Hacking Log – {{DATE:YYYY-MM-DD}}

### 🗓 Date  
**{{DATE:dddd, MMMM D, YYYY}}**

### 🕒 Time Started  
**{{TIME:HH:mm:ss}}**

---

### 🛠 Tools Used  
- nmap
- ffuf
- linPEAS
- ...
  
---

### 🔍 Target / Lab  
- **Box:** {{BOX_NAME}}  
- **IP:** {{BOX_IP}}

---

### 📋 Commands Run
```bash
nmap -p- -T4 -Pn {{BOX_IP}}
✅ Learning Detected
HTB boxes may expose no ports until after a reset

nmap -p- -Pn --min-rate=1000 is essential for full recon

GitHub Push Protection prevents accidental secret commits

git filter-repo removes secrets from commit history

.gitignore is a key defense for local loot handling

✅ Results
 User flag: HTB{...}

 Root flag: HTB{...}

 Open ports:

(document services once found)

🧠 Lessons Learned

❓ Follow-ups

🕒 Session Ended: {{TIME:HH:mm:ss}}

📚 Reference: [[notes/methodology.md]]

📌 End-of-Day Summary
 Reviewed commands

 Reflected on lessons

 Planned next steps

🔒 Git Cleanup Log – {{DATE:YYYY-MM-DD}}
 Removed leaked key using git filter-repo

 Updated .gitignore

 Verified push protection passed
