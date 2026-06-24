# Nexlayer working build fix

This file is the authoritative, pinned build solution for this repo. Nexlayer uses it verbatim on every run and will not override it. If a future build with this fix fails, Nexlayer appends/updates it rather than regenerating.

## Fixed Dockerfile

```dockerfile
FROM mirror.gcr.io/library/node:22-alpine AS builder
WORKDIR /app

# Install build dependencies for native modules (like bcryptjs if it uses native bindings)
RUN apk add --no-cache python3 make g++

# Install root dependencies
COPY package*.json ./
RUN npm ci

# Copy all source
COPY . .

# Fix for ERR_OSSL_EVP_UNSUPPORTED: Node 17+ uses OpenSSL 3, which breaks old webpack/react-scripts
# We set this env var specifically for the client build step
WORKDIR /app/client
COPY client/package*.json ./
RUN npm install
ENV NODE_OPTIONS=--openssl-legacy-provider
RUN npm run build

# Final Stage
FROM mirror.gcr.io/library/node:22-alpine
WORKDIR /app

# Copy root app files and node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app . 

# Copy the built client assets
COPY --from=builder /app/client/build ./client/build

ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

EXPOSE 3000
CMD ["node", "app.js"]
```
