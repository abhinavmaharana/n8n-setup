FROM n8nio/n8n:latest

# Switch to root user for package installation
USER root

# Install curl for healthcheck
RUN apk add --no-cache curl

# Switch back to node user
USER node

# Set environment variables
ENV NODE_ENV=production
ENV N8N_HOST=${N8N_HOST:-localhost}
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=${N8N_PROTOCOL:-http}
ENV N8N_USER_MANAGEMENT_DISABLED=${N8N_USER_MANAGEMENT_DISABLED:-false}
ENV N8N_BASIC_AUTH_ACTIVE=${N8N_BASIC_AUTH_ACTIVE:-true}
ENV N8N_BASIC_AUTH_USER=${N8N_BASIC_AUTH_USER:-admin}
ENV N8N_BASIC_AUTH_PASSWORD=${N8N_BASIC_AUTH_PASSWORD:-password}
ENV N8N_ENCRYPTION_KEY=${N8N_ENCRYPTION_KEY:-your-secret-key}
ENV N8N_DIAGNOSTICS_ENABLED=${N8N_DIAGNOSTICS_ENABLED:-false}
ENV N8N_DIAGNOSTICS_CONFIG_ENABLED=${N8N_DIAGNOSTICS_CONFIG_ENABLED:-false}
ENV N8N_PAYLOAD_SIZE_MAX=16777216
ENV EXECUTIONS_PROCESS=main
ENV EXECUTIONS_MODE=regular
ENV GENERIC_TIMEZONE=UTC
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Create directory for n8n data
RUN mkdir -p /home/node/.n8n

# Expose port
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5678/healthz || exit 1

# Start n8n
CMD ["n8n", "start"] 