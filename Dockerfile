ARG WORDPRESS_FPM_VERSION=6.5-fpm-alpine
FROM wordpress:${WORDPRESS_FPM_VERSION}

USER root

# Install system dependencies required by PHP extensions.
# Consider removing -dev packages for extensions you don't install below.
RUN set -eux; \
    apk update; \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        autoconf \
        libzip-dev \
        zlib-dev \
        libmemcached-dev \
        imagemagick-dev \
    ; \
    apk add --no-cache \
        libzip \
        zlib \
        libmemcached-libs \
        imagemagick \
    ;

# Install PHP extensions.
# IMPORTANT: Remove extensions you don't actually need (redis, memcached, imagick)
# to save memory and reduce potential attack surface.
RUN set -eux; \
    docker-php-ext-install \
        opcache \
        zip \
    ; \
    pecl install redis; \
    pecl install memcached; \
    pecl install imagick; \
    docker-php-ext-enable redis memcached imagick;

# Add common PHP runtime settings.
RUN set -eux; \
    { \
        echo "; Custom PHP settings"; \
        echo "memory_limit = 256M"; \
        echo "upload_max_filesize = 64M"; \
        echo "post_max_size = 64M"; \
        echo "max_execution_time = 300"; \
    } > /usr/local/etc/php/conf.d/zz-custom-php.ini

# Add Opcache settings optimized for lower memory.
RUN set -eux; \
    { \
        echo "; Optimized Opcache settings"; \
        echo "opcache.enable=1"; \
        # Lowered memory consumption for 1-2GB RAM VPS.
        echo "opcache.memory_consumption=64"; \
        echo "opcache.interned_strings_buffer=8"; \
        echo "opcache.max_accelerated_files=4000"; \
        echo "opcache.revalidate_freq=60"; \
        echo "opcache.fast_shutdown=1"; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

# Copy the custom FPM pool configuration.
# This overwrites the default www.conf pool settings.
COPY config/php-fpm-pool.conf /usr/local/etc/php-fpm.d/zz-optimized-pool.conf

# Clean up build dependencies.
RUN apk del .build-deps; \
    rm -rf /tmp/pear

# Switch back to the default non-privileged user.
USER www-data

# Default CMD ["php-fpm"] is inherited.
