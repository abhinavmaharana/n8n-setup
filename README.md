# n8n on Railway

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/your-username/n8n-docker)

## Overview

This repository contains a Dockerized n8n setup ready for deployment on Railway. n8n is a workflow automation platform that helps you automate tasks across different services.

## Quick Deploy

1. Click the "Deploy on Railway" button above
2. Sign in to Railway (or create an account)
3. Follow the deployment wizard
4. Set up your environment variables (see below)

## Environment Variables

The following environment variables are pre-configured in the Dockerfile but can be overridden in Railway:

| Variable                | Default Value              | Description                 |
| ----------------------- | -------------------------- | --------------------------- |
| N8N_PORT                | 5678                       | Port n8n listens on         |
| N8N_HOST                | 0.0.0.0                    | Host to bind to             |
| N8N_BASIC_AUTH_ACTIVE   | true                       | Enable basic authentication |
| N8N_BASIC_AUTH_USER     | lndautomation@razorpay.com | Username for basic auth     |
| N8N_BASIC_AUTH_PASSWORD | razorpay123!@#$%^          | Password for basic auth     |

### Security Recommendations

1. **Default Credentials**

   - Username: lndautomation@razorpay.com
   - Password: razorpay123!@#$%^
   - These credentials are pre-configured for Razorpay LND automation

2. **Additional Security Measures**
   - Enable IP restrictions in Railway if possible
   - Use a custom domain with SSL
   - Regularly rotate credentials
   - Monitor access logs

### Additional Variables to Set in Railway

After your first deployment, set these in Railway's dashboard:

- `WEBHOOK_TUNNEL_URL`: Set this to your Railway app's public URL (e.g., `https://your-app.up.railway.app/`)

## Data Persistence with MongoDB

For persistent data storage, we use MongoDB. You can add a MongoDB database in Railway:

1. Go to your project in Railway
2. Click "New"
3. Select "Database" → "MongoDB"
4. Add these environment variables to your n8n service:
   ```
   DB_TYPE=mongodb
   DB_MONGODB_CONNECTION_URL=mongodb://<username>:<password>@<host>:<port>/n8n
   ```

### MongoDB Connection Details

The MongoDB connection URL will be provided by Railway after you create the database. It will look something like this:

```
mongodb://mongo:<password>@containers-us-west-XX.railway.app:XXXXX
```

Make sure to:

1. Replace `<password>` with the actual password
2. Add `/n8n` at the end of the URL to specify the database name
3. Set the connection URL in Railway's environment variables

### MongoDB Security Notes

1. **Connection Security**

   - MongoDB connection is automatically secured by Railway
   - The connection uses SSL/TLS by default
   - Credentials are managed by Railway

2. **Data Backup**

   - Railway provides automatic backups for MongoDB
   - Consider setting up additional backup solutions for critical data

3. **Performance**
   - MongoDB is well-suited for n8n's document-based storage needs
   - Railway's MongoDB instance is optimized for performance

## Manual Deployment Steps

### Via Railway CLI

1. Install Railway CLI:

   ```bash
   npm i -g railway
   ```

2. Login to Railway:

   ```bash
   railway login
   ```

3. Initialize project:

   ```bash
   railway init
   ```

4. Deploy:

   ```bash
   railway up
   ```

5. Set environment variables:
   ```bash
   railway variables set N8N_BASIC_AUTH_ACTIVE true
   railway variables set N8N_BASIC_AUTH_USER n8n_admin
   railway variables set N8N_BASIC_AUTH_PASSWORD n8n_secure_2024!
   ```

### Via Railway Web UI

1. Push this repository to GitHub
2. Go to [Railway](https://railway.app/)
3. Click "New Project" → "Deploy from GitHub Repo"
4. Select this repository
5. Railway will automatically detect the Dockerfile and build
6. Set environment variables in the "Variables" tab
7. Deploy the project

## Accessing Your n8n Instance

After deployment:

1. Railway will provide a public URL
2. Access n8n at that URL
3. Log in with the credentials you set in the environment variables

## Security Notes

- Change the default password immediately after first login
- Consider setting up additional security measures like IP restrictions
- Keep your Railway API tokens secure

## Support

For issues with n8n, visit the [n8n community](https://community.n8n.io/).
For Railway-specific issues, check the [Railway documentation](https://docs.railway.app/).
