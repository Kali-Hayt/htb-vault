#!/bin/bash

# Show a reminder at 23:55 every day
while true; do
    current_time=$(date +%H:%M)
    if [[ "$current_time" == "23:55" ]]; then
        echo -e "\n⏰ [WARNING] It's 23:55! Run 'endlog' now to close your session before midnight. ⏳"
        notify-send "⏰ Time to endlog!" "It's almost midnight — finalize your HTB notes!" 2>/dev/null
        sleep 60
    fi
    sleep 30
done
