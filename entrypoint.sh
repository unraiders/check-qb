#!/bin/sh

echo "[$(date)] Starting entrypoint.sh"
echo "[$(date)] Timezone set to: $TZ"
echo "[$(date)] Scheduled time set to: $HORA"
echo "[$(date)] Debug: $DEBUG"

last_run=""

while true; do
    current_time=$(date +%-H:%M)
    
    if [ "$DEBUG" = "1" ]; then
        echo "[$(date)] Checking time - Current: $current_time, Scheduled: $HORA"
    fi
    
    if [ "$current_time" = "$HORA" ] && [ "$current_time" != "$last_run" ]; then
        echo "[$(date)] Time match! Running check-qb.py at scheduled time: $HORA"
        python /app/check-qb.py
        last_run=$current_time
    fi
    
    sleep 30
done