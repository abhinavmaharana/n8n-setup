# Deploying n8n to Google Cloud Run

This guide will help you deploy n8n to Google Cloud Run with MongoDB and Redis.

## Prerequisites

1. Google Cloud Account
2. Google Cloud SDK installed
3. Docker installed locally
4. Git installed

## Setup Steps

### 1. Enable Required APIs

```bash
# Enable required APIs
gcloud services enable \
  run.googleapis.com \
  cloudbuild.googleapis.com \
  artifactregistry.googleapis.com \
  mongodb.googleapis.com \
  redis.googleapis.com
```

### 2. Create MongoDB Atlas Database

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create a free cluster
3. Create a database user
4. Get your connection string
5. Add your IP to the whitelist

### 3. Create Redis Instance

1. Go to Google Cloud Console
2. Navigate to Memorystore
3. Create a Redis instance
4. Note the connection details

### 4. Build and Push Docker Image

```bash
# Set your project ID
export PROJECT_ID=your-project-id

# Build the image
docker build -t gcr.io/$PROJECT_ID/n8n .

# Push to Google Container Registry
docker push gcr.io/$PROJECT_ID/n8n
```

### 5. Deploy to Cloud Run

```bash
# Deploy the service
gcloud run deploy n8n \
  --image gcr.io/$PROJECT_ID/n8n \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --memory 1Gi \
  --cpu 1 \
  --min-instances 0 \
  --max-instances 10 \
  --set-env-vars="
    N8N_HOST=your-cloud-run-url
    N8N_PROTOCOL=https
    N8N_EDITOR_BASE_URL=https://your-cloud-run-url
    N8N_BASIC_AUTH_ACTIVE=true
    N8N_BASIC_AUTH_USER=admin
    N8N_BASIC_AUTH_PASSWORD=your_secure_password
    N8N_ENCRYPTION_KEY=your_32_character_encryption_key
    MONGODB_URL=your_mongodb_connection_string
    REDIS_HOST=your_redis_host
    REDIS_PORT=6379
    REDIS_PASSWORD=your_redis_password
    GENERIC_TIMEZONE=UTC
  "
```

### 6. Set Up Cloud Storage for Persistence

```bash
# Create a bucket
gsutil mb gs://n8n-data-$PROJECT_ID

# Set up Cloud Storage FUSE
gcloud run services update n8n \
  --update-env-vars="N8N_STORAGE_BACKEND=googleCloudStorage" \
  --update-env-vars="N8N_STORAGE_GOOGLE_CLOUD_STORAGE_BUCKET=n8n-data-$PROJECT_ID"
```

## Environment Variables

Required environment variables for Cloud Run:

```env
# n8n Configuration
N8N_HOST=your-cloud-run-url
N8N_PROTOCOL=https
N8N_EDITOR_BASE_URL=https://your-cloud-run-url
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

## Cost Optimization

1. Set minimum instances to 0 to avoid charges when idle
2. Use appropriate memory and CPU settings
3. Monitor usage with Cloud Monitoring
4. Set up budget alerts

## Monitoring and Logging

1. View logs:

```bash
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=n8n"
```

2. Monitor metrics in Cloud Console:
   - Request count
   - Latency
   - Memory usage
   - CPU usage

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

1. Service won't start:

   - Check logs: `gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=n8n"`
   - Verify environment variables
   - Check memory and CPU limits

2. Database connection issues:

   - Verify MongoDB connection string
   - Check IP whitelist
   - Verify Redis connection details

3. Performance issues:

   - Monitor Cloud Run metrics
   - Adjust memory and CPU settings
   - Check database performance

4. Cost issues:
   - Review Cloud Run pricing
   - Set up budget alerts
   - Optimize resource usage

## Security Best Practices

1. Use strong passwords
2. Enable authentication
3. Use HTTPS
4. Set up IAM roles properly
5. Regular security updates
6. Monitor access logs

## Maintenance

1. Regular updates:

```bash
# Update the image
docker build -t gcr.io/$PROJECT_ID/n8n .
docker push gcr.io/$PROJECT_ID/n8n
gcloud run services update n8n --image gcr.io/$PROJECT_ID/n8n
```

2. Monitor costs:

   - Set up budget alerts
   - Review Cloud Run pricing
   - Optimize resource usage

3. Regular backups:
   - Schedule MongoDB backups
   - Backup Redis data
   - Test restore procedures

## License

This project is licensed under the MIT License - see the LICENSE file for details.
