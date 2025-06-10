# Self-Hosted n8n Setup for Railway

This repository contains the configuration for running a self-hosted n8n instance on Railway with MongoDB and Redis.

## Prerequisites

- Railway account
- Railway CLI (optional)
- Git

## Railway Setup

1. Create a new project in Railway:

   - Go to [Railway Dashboard](https://railway.app/dashboard)
   - Click "New Project"
   - Select "Deploy from GitHub repo"

2. Add the following services to your Railway project:

   - MongoDB (from Railway's database templates)
   - Redis (from Railway's database templates)
   - n8n (from this repository)

3. Configure the following environment variables in Railway:

   ```env
   # n8n Configuration
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
   NODE_ENV=production

   # Railway automatically provides these variables
   RAILWAY_STATIC_URL=your-railway-app-url
   PORT=5678
   MONGODB_URL=your-mongodb-url
   REDIS_HOST=your-redis-host
   REDIS_PORT=your-redis-port
   REDIS_PASSWORD=your-redis-password
   ```

## Local Development

1. Clone this repository:

   ```bash
   git clone <repository-url>
   cd self-hosted-n8n
   ```

2. Create a `.env` file with the following content (replace the values with your own):

   ```env
   # n8n Configuration
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
   NODE_ENV=production

   # For local development
   RAILWAY_STATIC_URL=http://localhost:5678
   PORT=5678
   MONGODB_URL=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@mongodb:27017/${MONGO_DB}?authSource=admin
   REDIS_HOST=redis
   REDIS_PORT=6379
   REDIS_PASSWORD=your_secure_redis_password
   ```

3. Start the services:

   ```bash
   docker-compose up -d
   ```

4. Access n8n at `http://localhost:5678`

## Railway Deployment Features

- Automatic HTTPS
- Built-in monitoring
- Automatic deployments from Git
- Database backups
- Easy scaling
- Persistent storage
- Health checks

## Security Considerations

- Use strong passwords for all services
- Enable basic authentication
- Use a strong encryption key
- Keep the system updated
- Use Railway's built-in security features
- Disabled diagnostics for better privacy
- Using health checks for better monitoring

## Backup and Restore

Railway provides automatic backups for MongoDB and Redis. However, you can also perform manual backups:

### Backup

```bash
# Backup n8n data (if using persistent storage)
tar -czf n8n_backup.tar.gz data/n8n

# Backup MongoDB (using Railway CLI)
railway connect
mongodump --uri=${MONGODB_URL} --out=./mongodb_backup

# Backup Redis (using Railway CLI)
railway connect
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} -a ${REDIS_PASSWORD} SAVE
```

### Restore

```bash
# Restore n8n data
tar -xzf n8n_backup.tar.gz

# Restore MongoDB
mongorestore --uri=${MONGODB_URL} ./mongodb_backup

# Restore Redis
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} -a ${REDIS_PASSWORD} FLUSHALL
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} -a ${REDIS_PASSWORD} --pipe < dump.rdb
```

## Maintenance

- Monitor Railway dashboard for service health
- Check logs in Railway dashboard
- Keep dependencies updated
- Review n8n release notes
- Monitor resource usage in Railway dashboard

## Troubleshooting

1. If n8n fails to start:

   - Check Railway logs
   - Verify environment variables
   - Check service health in Railway dashboard

2. MongoDB connection issues:

   - Verify MongoDB URL in Railway
   - Check MongoDB service health
   - Verify network connectivity

3. Redis connection issues:

   - Verify Redis credentials in Railway
   - Check Redis service health
   - Verify network connectivity

4. Performance issues:
   - Check resource usage in Railway dashboard
   - Monitor n8n execution logs
   - Consider upgrading Railway plan if needed
   - Check system resources in Railway dashboard

## License

This project is licensed under the MIT License - see the LICENSE file for details.
