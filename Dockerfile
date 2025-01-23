<<<<<<< HEAD
# Use Node.js LTS version
FROM node:20-alpine
=======
# Use Node.js 22.13.0 as the base image
FROM node:22.13.0
>>>>>>> 3daa16a2067b98c5a0918049f1fd9b34c58e75cf

# Set working directory
WORKDIR /usr/src/app

# Add non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Change ownership to non-root user
RUN chown -R appuser:appgroup /usr/src/app

# Switch to non-root user
USER appuser

# Set environment
ENV NODE_ENV=production

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/ || exit 1

# Expose port
EXPOSE 3000

# Start application
CMD ["node", "index.js"]