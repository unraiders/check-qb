FROM python:3.11-alpine

LABEL maintainer="unraiders"
LABEL version="1.0.0"
LABEL description="Monitoreo de QBittorrent con notificaciones de Telegram"

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Create app directory and set permissions
WORKDIR /app

# Copy script and config files first
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY check-qb.py .

# Set ownership of all files
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

ENTRYPOINT ["/app/entrypoint.sh"]
