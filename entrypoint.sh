#!/bin/sh

# Cargar variables de entorno usando Python
python3 << END
from dotenv import load_dotenv
import os
load_dotenv()
hora = os.getenv('HORA')
with open('/tmp/env_vars', 'w') as f:
    f.write(f"HORA={hora}\n")
END

# Cargar las variables de entorno desde el archivo temporal
. /tmp/env_vars

echo "[$(date)] Starting entrypoint.sh"
echo "[$(date)] Timezone set to: $TZ"
echo "[$(date)] Scheduled time set to: $HORA"

last_run=""
while true; do
    # Get current time in HH:MM format
    current_time=$(date +%H:%M)
    
    echo "[$(date)] Checking time - Current: $current_time, Scheduled: $HORA"
    
    # Check if it's time to run and hasn't been run in this minute
    if [ "$current_time" = "$HORA" ] && [ "$current_time" != "$last_run" ]; then
        echo "[$(date)] Time match! Running check-qb.py at scheduled time: $HORA"
        python /app/check-qb.py
        last_run=$current_time
    fi
    
    # Sleep for 30 seconds before next check
    sleep 30
done
