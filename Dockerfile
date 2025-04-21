FROM node:20-alpine AS base

# Install pnpm
RUN corepack enable && corepack prepare pnpm@10.8.1 --activate

# Set working directory
WORKDIR /app

# Install dependencies
FROM base AS dependencies
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN pnpm install --frozen-lockfile

# Build the application
FROM dependencies AS build
COPY . .
# Generate Prisma client before building the app
RUN cd /app/prisma && npx prisma generate
RUN pnpm build

# Runtime image
FROM base AS runtime

# Copy built application
COPY --from=build /app/.output /app/.output
COPY --from=build /app/prisma /app/prisma

# Install Prisma client and CLI (needed for runtime)
RUN cd /app && pnpm add @prisma/client@6.6.0 prisma@6.6.0

# Expose the port the app runs on
EXPOSE 3000

# Apply migrations and start the application
CMD cd /app && npx prisma migrate deploy && node /app/.output/server/index.mjs
