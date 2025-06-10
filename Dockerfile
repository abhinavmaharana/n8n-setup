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

# MongoDB Configuration
ENV DB_TYPE=mongodb
ENV DB_MONGODB_CONNECTION_URL=mongodb+srv://admin:admin@n8n.qnmxozt.mongodb.net/

# The base image already has the correct CMD, so we don't need to override it 