# Deploying n8n to Render

This guide will help you deploy n8n to Render with MongoDB.

## Prerequisites

1. Render Account
2. MongoDB Atlas Account
3. Git Account

## Setup Steps

### 1. Create MongoDB Atlas Database

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create a free cluster
3. Create a database user
4. Get your connection string
5. Add your IP to the whitelist (use 0.0.0.0/0 for Render)

### 2. Prepare Your Repository

1. Create a new repository with these files:

   - `Dockerfile`
   - `docker-compose.yml`
   - `.env.example`
   - `README.md`

2. Create a `.env.example` file:

   ```env
   # n8n Configuration
   N8N_HOST=your-render-app-url
   N8N_PROTOCOL=https
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
   NODE_ENV=production

   # MongoDB Configuration
   MONGODB_URL=your_mongodb_connection_string
   ```

### 3. Deploy to Render

1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click "New +" and select "Web Service"
3. Connect your GitHub repository
4. Configure the service:

   - Name: `n8n` (or your preferred name)
   - Environment: `Docker`
   - Region: Choose closest to your users
   - Branch: `main` (or your default branch)
   - Build Command: `docker-compose build`
   - Start Command: `docker-compose up`
   - Plan: `Free` (or choose a paid plan)

5. Add Environment Variables:

   - Click "Environment" tab
   - Add all variables from your `.env.example`
   - Make sure to set `N8N_HOST` to your Render URL
   - Set `N8N_PROTOCOL` to `https`

6. Click "Create Web Service"

## Render Configuration

### Free Tier Limitations

- 750 hours/month of free usage
- 512 MB RAM
- Shared CPU
- Automatic sleep after 15 minutes of inactivity

### Recommended Settings

- Memory: 512 MB (Free) or 1 GB (Paid)
- CPU: 0.1 (Free) or 0.5 (Paid)
- Auto-Deploy: Enabled
- Health Check Path: `/healthz`

## Environment Variables

Required environment variables for Render:

```env
# n8n Configuration
N8N_HOST=your-render-app-url
N8N_PROTOCOL=https
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
NODE_ENV=production

# MongoDB Configuration
MONGODB_URL=your_mongodb_connection_string
```

## Monitoring and Logging

1. View logs in Render dashboard:

   - Go to your service
   - Click on "Logs" tab
   - View real-time logs

2. Monitor metrics:
   - Response time
   - Memory usage
   - CPU usage
   - Request count

## Backup and Restore

### Backup

```bash
# Backup MongoDB
mongodump --uri=${MONGODB_URL} --out=./mongodb_backup
```

### Restore

```bash
# Restore MongoDB
mongorestore --uri=${MONGODB_URL} ./mongodb_backup
```

## Troubleshooting

1. Service won't start:

   - Check Render logs
   - Verify environment variables
   - Check MongoDB connection
   - Verify port configuration

2. Database connection issues:

   - Verify MongoDB connection string
   - Check IP whitelist
   - Verify database credentials
   - Check network connectivity

3. Performance issues:

   - Monitor resource usage
   - Check execution logs
   - Consider upgrading plan
   - Optimize workflows

4. Sleep issues (Free tier):
   - Service sleeps after 15 minutes
   - First request after sleep will be slow
   - Consider paid plan for 24/7 uptime

## Maintenance

1. Regular updates:

   - Pull latest n8n image
   - Update environment variables
   - Test after updates
   - Monitor performance

2. Monitor usage:

   - Check Render dashboard
   - Monitor database usage
   - Track execution times
   - Review error rates

3. Regular backups:
   - Schedule MongoDB backups
   - Test restore procedures
   - Keep backup copies

## Security Best Practices

1. Use strong passwords
2. Enable authentication
3. Use HTTPS (automatic with Render)
4. Regular security updates
5. Monitor access logs
6. Keep dependencies updated

## License

This project is licensed under the MIT License - see the LICENSE file for details.
