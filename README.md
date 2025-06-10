# Simple Self-Hosted n8n with MongoDB

A simple setup for running n8n locally with MongoDB.

## Prerequisites

- Docker
- Docker Compose

## Setup

1. Create the data directories:

   ```bash
   mkdir -p data/n8n data/mongodb
   ```

2. Start n8n and MongoDB:

   ```bash
   docker-compose up -d
   ```

3. Access n8n:
   - Open http://localhost:5678 in your browser
   - Login with:
     - Username: admin
     - Password: password

## Default Configuration

- Port: 5678
- Database: MongoDB
  - Username: n8n
  - Password: password
  - Database: n8n
- Authentication: Basic Auth enabled
- Default credentials:
  - Username: admin
  - Password: password

## Security Note

For production use, make sure to:

1. Change the default password
2. Change the encryption key
3. Use HTTPS
4. Set up proper authentication
5. Change MongoDB credentials
