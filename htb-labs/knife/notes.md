# knife

---


### gobuster run (2025-05-25_15-10-28)
```
gobuster dir -u http://10.10.11.242 -w /usr/share/wordlists/dirb/common.txt
```


### ffuf run (2025-05-25_15-15-32)
```
ffuf -u http://10.10.11.242/FUZZ -w /usr/share/wordlists/dirb/common.txt
```


(jq not installed or JSON missing — skipping summary)

### ffuf run (2025-05-25_15-19-07)
```
ffuf -u https://testphp.vulnweb.com/FUZZ -w /usr/share/wordlists/dirb/common.txt
```


**FFUF Results:**

### ffuf run (2025-05-25_15-20-20)
```
ffuf -u https://testphp.vulnweb.com/FUZZ -w /usr/share/wordlists/dirb/big.txt
```


**FFUF Results:**
