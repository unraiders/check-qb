#!/bin/sh

while true; do
    # Get current time in HH:MM format
    current_time=$(date +%H:%M)
    
    # Get scheduled time from environment variable
    scheduled_time=$(echo $HORA)
    
    if [ "$current_time" = "$scheduled_time" ]; then
        echo "Running check-qb.py at scheduled time: $scheduled_time"
        python /app/check-qb.py
    fi
    
    # Sleep for 60 seconds before next check
    sleep 60
done
