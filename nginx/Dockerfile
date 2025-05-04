ARG NGINX_VERSION=1.27-alpine
FROM nginx:${NGINX_VERSION}

# Copy our Nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf

# Verify the configuration
RUN nginx -t

# We'll use the default command from the Nginx image
# CMD ["nginx", "-g", "daemon off;"]
