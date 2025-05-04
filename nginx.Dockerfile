ARG NGINX_VERSION=1.27-alpine
FROM nginx:${NGINX_VERSION}

# Copy nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf

