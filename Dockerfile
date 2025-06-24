# Dockerfile
FROM php:8.2-fpm-alpine

RUN apk add --no-cache \
    bash \
    curl \
    git \
    unzip \
    libzip-dev \
    zlib-dev \
    icu-dev \
    libxml2-dev \
    oniguruma-dev \
    libpng-dev

RUN docker-php-ext-install pdo pdo_mysql mbstring zip intl

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www
COPY . .

RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 storage bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
