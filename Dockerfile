FROM mirror.gcr.io/library/node:22-alpine AS builder
WORKDIR /app
# Install build tools for native modules (bcryptjs)
RUN apk add --no-cache python3 make g++ linux-headers
COPY package*.json ./
RUN npm ci
COPY . .
# Fix for ERR_OSSL_EVP_UNSUPPORTED: Node 17+ uses OpenSSL 3
ENV NODE_OPTIONS=--openssl-legacy-provider
# Build the client-side React app
RUN npm run heroku-postbuild

FROM mirror.gcr.io/library/node:22-alpine
WORKDIR /app
COPY --from=builder /app ./
ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0
EXPOSE 3000
CMD ["node", "app.js"]