FROM nginx:1.25-alpine

# Add custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create directory for Nginx pid file
RUN mkdir -p /var/run/nginx

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

# Expose HTTP port
EXPOSE 80