FROM php:8.2-alpine3.18

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN apk add openssl zip unzip git curl wget
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install pdo pdo_mysql

RUN cd /var/ && \
    wget https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem 

COPY sample-app/ /var/www/html
WORKDIR /var/www/html

RUN cd /var/www/html && \
    composer install --no-interaction --optimize-autoloader

RUN cd /var/www/html && \
    php artisan optimize

CMD ["php","artisan","serve", "--host=0.0.0.0","--port=80"]

EXPOSE 80