ARG NGINX_VERSION=1.27-alpine
FROM nginx:${NGINX_VERSION}

# Copy nginx.conf configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy default.conf configuration
COPY default.conf /etc/nginx/conf.d/default.conf
