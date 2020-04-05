FROM php:7.3.16-fpm-alpine3.11

RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql

RUN apk add --no-cache openssl
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www

RUN rm -rf /var/www/html
COPY . /var/www
RUN ln -s public html

RUN chmod 755 -R /var/www/storage
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap

RUN composer install && \
    cp .env.example .env && \
    php artisan key:generate && \
    php artisan config:cache

RUN ls -la
RUN cat .env

EXPOSE 9000
ENTRYPOINT ["php-fpm"]
