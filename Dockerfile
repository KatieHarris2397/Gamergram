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
# The script 'heroku-postbuild' runs 'npm install --prefix client && npm run build --prefix client'
RUN npm run heroku-postbuild

FROM mirror.gcr.io/library/node:22-alpine
WORKDIR /app

# Copy entire application from builder
COPY --from=builder /app ./

# Ensure production environment settings
ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0
EXPOSE 3000

# Create the service discovery start script
# We use a slightly more robust script to ensure MONGO_URI is set
RUN printf '#!/bin/sh\nif [ -n "$ROOT_URL" ]; then\n  _h=$(echo "$ROOT_URL" | sed "s|https://||" | sed "s|\.cloud\.nexlayer\.ai||")\n  _d=$(echo "$_h" | cut -d- -f3-)\n  export MONGO_URI="mongodb://${_d}-mongo-service:27017/gamergram"\nfi\nexec "$@"' > /nx-start.sh && chmod +x /nx-start.sh

ENTRYPOINT ["/bin/sh", "/nx-start.sh"]
CMD ["node", "app.js"]