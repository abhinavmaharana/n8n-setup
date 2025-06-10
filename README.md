# Self-Hosted n8n Setup

This repository contains the configuration for running a self-hosted n8n instance with MongoDB and Redis. It's compatible with various hosting platforms.

## Free Deployment Options

### 1. Render

1. Create a new Web Service
2. Connect your GitHub repository
3. Set the following:
   - Environment: Docker
   - Build Command: `docker-compose build`
   - Start Command: `docker-compose up`
4. Add environment variables:
   ```env
   N8N_HOST=your-render-app-url
   N8N_PROTOCOL=https
   N8N_EDITOR_BASE_URL=https://your-render-app-url
   MONGODB_URL=your-mongodb-url
   REDIS_HOST=your-redis-host
   REDIS_PORT=6379
   REDIS_PASSWORD=your-redis-password
   ```

### 2. Fly.io

1. Install Fly CLI: `curl -L https://fly.io/install.sh | sh`
2. Login: `fly auth login`
3. Launch app: `fly launch`
4. Set secrets:
   ```bash
   fly secrets set N8N_HOST=your-fly-app-url
   fly secrets set N8N_PROTOCOL=https
   fly secrets set MONGODB_URL=your-mongodb-url
   fly secrets set REDIS_HOST=your-redis-host
   fly secrets set REDIS_PASSWORD=your-redis-password
   ```

### 3. Oracle Cloud Free Tier

1. Create a VM instance
2. Install Docker and Docker Compose
3. Clone this repository
4. Set up environment variables
5. Run with `docker-compose up -d`

### 4. Google Cloud Run

1. Enable Cloud Run API
2. Build and push Docker image
3. Deploy to Cloud Run
4. Set environment variables in Cloud Run console

### 5. Hetzner Cloud (Student)

1. Create account with student verification
2. Create a new project
3. Deploy a new server
4. Install Docker and Docker Compose
5. Deploy using this configuration

## Environment Variables

Required variables for all platforms:

```env
# n8n Configuration
N8N_HOST=your-app-url
N8N_PROTOCOL=https
N8N_EDITOR_BASE_URL=https://your-app-url
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

# Database Configuration
MONGODB_URL=your-mongodb-url
REDIS_HOST=your-redis-host
REDIS_PORT=6379
REDIS_PASSWORD=your-redis-password
```

## Platform-Specific Considerations

### Render

- Free tier includes 750 hours/month
- Automatic HTTPS
- Built-in MongoDB and Redis
- Automatic deployments

### Fly.io

- Free tier includes 3 shared VMs
- Global edge network
- Automatic HTTPS
- Good for global distribution

### Oracle Cloud

- Always free resources
- Full control over infrastructure
- Good for learning and development
- Requires more manual setup

### Google Cloud Run

- Pay only for what you use beyond free tier
- Automatic scaling
- Good for variable workloads
- Requires more configuration

### Hetzner Cloud

- Good performance
- European data centers
- Student program available
- Full root access

## Security Considerations

- Use strong passwords
- Enable basic authentication
- Use HTTPS
- Keep system updated
- Regular backups
- Monitor resource usage

## Backup and Restore

### Backup

```bash
# Backup n8n data
tar -czf n8n_backup.tar.gz data/n8n

# Backup MongoDB
mongodump --uri=${MONGODB_URL} --out=./mongodb_backup

# Backup Redis
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

- Monitor platform dashboard
- Check logs regularly
- Keep dependencies updated
- Review n8n release notes
- Monitor resource usage

## Troubleshooting

1. If n8n fails to start:

   - Check platform logs
   - Verify environment variables
   - Check service health

2. Database connection issues:

   - Verify database URLs
   - Check service health
   - Verify network connectivity

3. Redis connection issues:

   - Verify Redis credentials
   - Check service health
   - Verify network connectivity

4. Performance issues:
   - Check resource usage
   - Monitor execution logs
   - Consider platform limits
   - Check system resources

## License

This project is licensed under the MIT License - see the LICENSE file for details.
