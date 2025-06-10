# Deploying n8n to Vercel

This guide will help you deploy n8n to Vercel with MongoDB and Redis.

## Prerequisites

1. Vercel Account
2. MongoDB Atlas Account
3. Redis Cloud Account (or similar)
4. Git Account
5. Node.js installed locally

## Setup Steps

### 1. Create MongoDB Atlas Database

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create a free cluster
3. Create a database user
4. Get your connection string
5. Add your IP to the whitelist

### 2. Create Redis Instance

1. Go to [Redis Cloud](https://redis.com/try-free/)
2. Create a free account
3. Create a new subscription
4. Create a database
5. Note the connection details

### 3. Prepare Your Repository

1. Clone this repository
2. Install dependencies:

   ```bash
   npm install
   ```

3. Create a `.env` file with your configuration:
   ```env
   N8N_HOST=your-vercel-url
   N8N_PROTOCOL=https
   N8N_EDITOR_BASE_URL=https://your-vercel-url
   N8N_BASIC_AUTH_ACTIVE=true
   N8N_BASIC_AUTH_USER=admin
   N8N_BASIC_AUTH_PASSWORD=your_secure_password
   N8N_ENCRYPTION_KEY=your_32_character_encryption_key
   MONGODB_URL=your_mongodb_connection_string
   REDIS_HOST=your_redis_host
   REDIS_PORT=6379
   REDIS_PASSWORD=your_redis_password
   GENERIC_TIMEZONE=UTC
   ```

### 4. Deploy to Vercel

1. Install Vercel CLI:

   ```bash
   npm i -g vercel
   ```

2. Login to Vercel:

   ```bash
   vercel login
   ```

3. Deploy:

   ```bash
   vercel
   ```

4. Set environment variables in Vercel dashboard:
   - Go to your project settings
   - Navigate to Environment Variables
   - Add all variables from your `.env` file

## Important Considerations

### Limitations

1. **Serverless Limitations**:

   - Cold starts
   - Execution time limits
   - Memory constraints
   - No persistent storage

2. **Database Considerations**:

   - Use MongoDB Atlas for database
   - Use Redis Cloud for caching
   - Ensure proper connection pooling

3. **Workflow Considerations**:
   - Keep workflows lightweight
   - Avoid long-running operations
   - Use webhooks for triggers
   - Consider execution time limits

### Best Practices

1. **Performance**:

   - Optimize workflow execution
   - Use efficient database queries
   - Implement proper caching
   - Monitor execution times

2. **Security**:

   - Use strong passwords
   - Enable authentication
   - Use HTTPS
   - Regular security updates

3. **Monitoring**:
   - Use Vercel Analytics
   - Monitor database performance
   - Track execution times
   - Set up alerts

## Environment Variables

Required environment variables for Vercel:

```env
# n8n Configuration
N8N_HOST=your-vercel-url
N8N_PROTOCOL=https
N8N_EDITOR_BASE_URL=https://your-vercel-url
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
MONGODB_URL=your_mongodb_connection_string
REDIS_HOST=your_redis_host
REDIS_PORT=6379
REDIS_PASSWORD=your_redis_password
```

## Monitoring and Logging

1. View logs in Vercel dashboard:

   - Go to your project
   - Click on "Deployments"
   - Select a deployment
   - Click on "Runtime Logs"

2. Monitor metrics:
   - Function execution times
   - Memory usage
   - Error rates
   - Database performance

## Backup and Restore

### Backup

```bash
# Backup MongoDB
mongodump --uri=${MONGODB_URL} --out=./mongodb_backup

# Backup Redis
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} -a ${REDIS_PASSWORD} SAVE
```

### Restore

```bash
# Restore MongoDB
mongorestore --uri=${MONGODB_URL} ./mongodb_backup

# Restore Redis
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} -a ${REDIS_PASSWORD} FLUSHALL
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} -a ${REDIS_PASSWORD} --pipe < dump.rdb
```

## Troubleshooting

1. Deployment issues:

   - Check build logs
   - Verify environment variables
   - Check Node.js version
   - Review Vercel limits

2. Runtime issues:

   - Check function logs
   - Monitor execution times
   - Verify database connections
   - Check memory usage

3. Database issues:

   - Verify connection strings
   - Check IP whitelist
   - Monitor database performance
   - Review connection limits

4. Performance issues:
   - Optimize workflows
   - Review execution times
   - Check database queries
   - Monitor memory usage

## Maintenance

1. Regular updates:

   ```bash
   # Update dependencies
   npm update

   # Deploy updates
   vercel --prod
   ```

2. Monitor usage:

   - Check Vercel dashboard
   - Monitor database usage
   - Track execution times
   - Review error rates

3. Regular backups:
   - Schedule MongoDB backups
   - Backup Redis data
   - Test restore procedures

## License

This project is licensed under the MIT License - see the LICENSE file for details.
