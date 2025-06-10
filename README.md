# Self-Hosted n8n Setup

This repository contains the configuration for running a self-hosted n8n instance with MongoDB. Redis is optional and can be added for production deployments.

## Deployment Options

### 1. Basic Setup (Without Redis)

- Simpler configuration
- Good for:
  - Small to medium workflows
  - Single instance deployments
  - Testing and development
  - Simple automation tasks
- Uses in-memory queue by default

### 2. Production Setup (With Redis)

- More robust configuration
- Better for:
  - Multiple instances
  - High-load scenarios
  - Production environments
  - Workflows with many concurrent executions
- Requires Redis configuration

## Prerequisites

- Docker
- Docker Compose
- Git
- MongoDB (required)
- Redis (optional, for production)

## Setup Instructions

1. Clone this repository:

   ```bash
   git clone <repository-url>
   cd self-hosted-n8n
   ```

2. Create a `.env` file with the following content (replace the values with your own):

   ```env
   # n8n Configuration
   N8N_HOST=localhost
   N8N_PROTOCOL=http
   N8N_PORT=5678
   N8N_USER_MANAGEMENT_DISABLED=false
   N8N_BASIC_AUTH_ACTIVE=true
   N8N_BASIC_AUTH_USER=admin
   N8N_BASIC_AUTH_PASSWORD=your_secure_password
   N8N_ENCRYPTION_KEY=your_32_character_encryption_key
   N8N_DIAGNOSTICS_ENABLED=false
   N8N_DIAGNOSTICS_CONFIG_ENABLED=false
   N8N_PAYLOAD_SIZE_MAX=16MB
   EXECUTIONS_PROCESS=main
   EXECUTIONS_MODE=regular
   GENERIC_TIMEZONE=UTC

   # MongoDB Configuration
   MONGO_USER=n8n
   MONGO_PASSWORD=your_secure_mongodb_password
   MONGO_DB=n8n
   MONGODB_URL=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@mongodb:27017/${MONGO_DB}?authSource=admin

   # Redis Configuration (Optional, for production)
   # REDIS_HOST=redis
   # REDIS_PORT=6379
   # REDIS_PASSWORD=your_secure_redis_password
   ```

3. Create the data directories:

   ```bash
   mkdir -p data/n8n data/mongodb
   ```

4. Start the services:

   ```bash
   docker-compose up -d
   ```

5. Access n8n at `http://localhost:5678`

## Adding Redis (Optional)

To add Redis for production use:

1. Uncomment Redis configuration in `.env`
2. Add Redis service to docker-compose.yml:

   ```yaml
   redis:
     image: redis:7-alpine
     restart: always
     command: redis-server --requirepass ${REDIS_PASSWORD} --appendonly yes
     volumes:
       - ./data/redis:/data
     networks:
       - n8n-network
     healthcheck:
       test: ["CMD", "redis-cli", "ping"]
       interval: 30s
       timeout: 10s
       retries: 3
   ```

3. Add Redis environment variables to n8n service:

   ```yaml
   - QUEUE_BULL_REDIS_HOST=${REDIS_HOST}
   - QUEUE_BULL_REDIS_PORT=${REDIS_PORT}
   - QUEUE_BULL_REDIS_PASSWORD=${REDIS_PASSWORD}
   ```

4. Create Redis data directory:
   ```bash
   mkdir -p data/redis
   ```

## Security Considerations

- Change all default passwords
- Use strong encryption key
- Consider using HTTPS in production
- Regularly backup the data directory
- Keep the system updated

## Backup and Restore

### Backup

```bash
# Backup n8n data
tar -czf n8n_backup.tar.gz data/n8n

# Backup MongoDB
docker-compose exec mongodb mongodump --username ${MONGO_USER} --password ${MONGO_PASSWORD} --authenticationDatabase admin --db ${MONGO_DB} --out /backup
docker cp $(docker-compose ps -q mongodb):/backup ./mongodb_backup
```

### Restore

```bash
# Restore n8n data
tar -xzf n8n_backup.tar.gz

# Restore MongoDB
docker cp ./mongodb_backup $(docker-compose ps -q mongodb):/backup
docker-compose exec mongodb mongorestore --username ${MONGO_USER} --password ${MONGO_PASSWORD} --authenticationDatabase admin --db ${MONGO_DB} /backup/${MONGO_DB}
```

## Maintenance

- Regularly check logs: `docker-compose logs -f`
- Monitor disk usage in the data directory
- Keep Docker images updated
- Review n8n release notes for updates

## Troubleshooting

1. If n8n fails to start:

   - Check logs: `docker-compose logs n8n`
   - Verify environment variables
   - Ensure ports are not in use

2. MongoDB connection issues:

   - Check MongoDB logs: `docker-compose logs mongodb`
   - Verify database credentials
   - Check network connectivity

3. Performance issues:
   - Monitor n8n execution logs
   - Consider adding Redis for better performance
   - Check system resources

## License

This project is licensed under the MIT License - see the LICENSE file for details.
