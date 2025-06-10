FROM n8nio/n8n:latest

# Install curl for healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV NODE_ENV=production
ENV N8N_PORT=8080
ENV N8N_PROTOCOL=https
ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_DIAGNOSTICS_CONFIG_ENABLED=false
ENV N8N_PAYLOAD_SIZE_MAX=16MB
ENV EXECUTIONS_PROCESS=main
ENV EXECUTIONS_MODE=regular

# Create directory for n8n data
RUN mkdir -p /home/node/.n8n

# Switch to non-root user
USER node

# Expose port 8080 (Cloud Run requirement)
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/healthz || exit 1 