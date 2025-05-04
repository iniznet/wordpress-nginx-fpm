# WordPress Nginx/PHP-FPM Stack for Coolify

This repository provides a Docker Compose setup for running WordPress with separate Nginx and PHP-FPM containers, optimized for deployment via Coolify.

## Usage

To use this configuration, please **clone or fork** this repository. Do not use it directly if you intend to make customizations to the Dockerfile, Nginx configuration, or PHP extensions.

## Disclaimer

This setup is provided as-is and should be considered **experimental**. While it aims to follow best practices, thorough testing in your specific environment is recommended before production use. You are free to use it in production if you deem it suitable for your needs, but do so at your own risk.

## Required & Optional Environment Variables

Configure the following environment variables in your Coolify application settings. Some variables have defaults or can potentially leverage Coolify's predefined variables (see link below).

### Mandatory Database Connection

*   `WORDPRESS_DB_HOST`: Hostname/IP and port of your database service (e.g., `db-service:3306`).
*   `WORDPRESS_DB_USER`: Database username.
*   `WORDPRESS_DB_PASSWORD`: Database password (**Mark as Secret**).
*   `WORDPRESS_DB_NAME`: Database name.

### Mandatory WordPress Security Keys & Salts

Generate unique values from `https://api.wordpress.org/secret-key/1.1/salt/` and set each one (**Mark all as Secret**).

*   `WORDPRESS_AUTH_KEY`
*   `WORDPRESS_SECURE_AUTH_KEY`
*   `WORDPRESS_LOGGED_IN_KEY`
*   `WORDPRESS_NONCE_KEY`
*   `WORDPRESS_AUTH_SALT`
*   `WORDPRESS_SECURE_AUTH_SALT`
*   `WORDPRESS_LOGGED_IN_SALT`
*   `WORDPRESS_NONCE_SALT`

### Version Configuration (Defaults provided if unset)

*   `WORDPRESS_FPM_VERSION`: Base WordPress FPM image tag (e.g., `6.5-fpm-alpine`).
*   `NGINX_VERSION`: Nginx image tag (e.g., `1.27-alpine`).

### Optional WordPress Configuration

*   `WORDPRESS_TABLE_PREFIX`: Database table prefix (defaults to `wp_`).
*   `WORDPRESS_DEBUG`: Set to `1` to enable WP_DEBUG (defaults to `0`).
*   `WORDPRESS_SITE_URL`: Public URL of your site. Can be set explicitly, or defaults to using the value of `$COOLIFY_URL` if available.
*   `WORDPRESS_HOME`: Home URL, often the same as `WORDPRESS_SITE_URL`. Can be set explicitly, or defaults to using the value of `$COOLIFY_URL` if available.

### Optional Nginx Configuration

*   `NGINX_HOST_PORT`: Host port to map to Nginx container's port 80. Set this only if you need to force a specific host port different from Coolify's default (which might be set in `$PORT`). Defaults to `80` if `$PORT` is also unset.

## Coolify Predefined Variables

Coolify automatically injects several predefined environment variables into your application's environment, such as `$COOLIFY_URL`, `$PORT`, and `$COOLIFY_RESOURCE_UUID` (used internally for unique container naming). You can reference these when setting other variables (e.g., `MY_VAR=$COOLIFY_URL`).

For a full list and explanation, see the official Coolify documentation:
[https://coolify.io/docs/knowledge-base/environment-variables](https://coolify.io/docs/knowledge-base/environment-variables)
