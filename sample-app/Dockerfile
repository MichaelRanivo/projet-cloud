FROM php:8.2-alpine3.18

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN apk add openssl zip unzip git curl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install pdo pdo_mysql
RUN composer --version

COPY sample-app/certif.crt /var/www/

COPY sample-app/ /app
WORKDIR /app

RUN composer dump-autoload --optimize
RUN composer update --optimize-autoloader
RUN composer install --no-interaction --optimize-autoloader

RUN php artisan config:cache
RUN php artisan event:cache
RUN php artisan route:cache
RUN php artisan view:cache
RUN php artisan optimize

CMD php artisan serve --host=0.0.0.0 --port=80
EXPOSE 80