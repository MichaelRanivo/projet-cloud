FROM composer:2.6.5 as build

COPY . /app
RUN composer install --prefer-dist --no-dev --optimize-autoloader --no-interaction && composer update

FROM php:8.2-alpine3.18 as deploy

RUN docker-php-ext-install pdo pdo_mysql

RUN cd /var/ && wget https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem 

COPY --from=build /app /var/www/html
RUN chmod 755 -R /var/www/html/storage/ && chown -R www-data:www-data /var/www/

WORKDIR /var/www/html/

CMD ["php","artisan","serve", "--host=0.0.0.0","--port=8080"]

EXPOSE 8080