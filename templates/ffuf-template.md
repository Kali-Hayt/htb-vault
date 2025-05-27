### 🧰 FFUF Scan Summary

**Target:** {{URL}}

```bash
ffuf -u {{URL}} -w {{WORDLIST}} -t 40 -o ffuf.json -of json

Notable Results:

/admin (200, Size: 1234)

/login (403, Size: 89)

Full Log: [[htb-labs/{{BOX_NAME}}/scans/ffuf_{{DATE}}.json]]
