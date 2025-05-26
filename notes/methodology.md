# 🎯 Hack The Box Methodology

A repeatable process for attacking any HTB machine (or real target), modeled after real-world penetration testing workflows.

---

## 🔍 1. Reconnaissance

**Objective:** Discover open ports and services.

```bash
nmap -p- -T4 --min-rate=1000 <target>  # Fast port scan
nmap -sC -sV -oA scans/full <target>   # Version & script scan
