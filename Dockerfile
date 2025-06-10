# Use the official n8n image
FROM n8nio/n8n:latest

# Expose the port n8n will run on
EXPOSE 5678

# Set default environment variables
ENV N8N_PORT=5678
ENV N8N_HOST=0.0.0.0
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=lndautomation@razorpay.com
ENV N8N_BASIC_AUTH_PASSWORD=razorpay123!@#$%^

# PostgreSQL Configuration
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_HOST=postgres
ENV DB_POSTGRESDB_PORT=5432
ENV DB_POSTGRESDB_DATABASE=n8n
ENV DB_POSTGRESDB_USER=postgres
ENV DB_POSTGRESDB_PASSWORD=postgres

# The base image already has the correct CMD, so we don't need to override it 