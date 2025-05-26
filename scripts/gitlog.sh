#!/bin/bash
cd ~/Obsidian/HTB || exit
git add .
git commit -m "📦 $(date '+%Y-%m-%d %H:%M:%S') - Daily sync"
git push
