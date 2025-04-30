# Base Marketplace

A modern e-commerce marketplace platform built with Nuxt.js and Posgresql that allows users to browse products, add them to cart, and process payments.

<p align="center">
  <img width="700" src="readme/lighthouse.png">
</p>

## Running the Project

### Local Development

1. Start the local database:

   ```bash
   docker-compose -f docker-compose.local-database.yml up -d
   ```

2. Install dependencies:

   ```bash
   pnpm i
   ```

3. Apply database migrations:

   ```bash
   pnpx prisma migrate deploy
   ```

4. Start the development server:
   ```bash
   pnpm dev
   ```

The application will be available at http://localhost:3000.

### Docker Deployment

For staging environment:

```bash
docker-compose -f docker-compose.staging.yml up -d --build
```

For production environment:

```bash
docker-compose -f docker-compose.production.yml up -d --build
```
