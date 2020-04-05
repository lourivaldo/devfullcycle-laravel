#!/bin/bash

#RUN composer install && \
#    cp .env.example .env && \
#    php artisan key:generate && \
#    php artisan config:cache
#php artisan key:generate

php artisan migrate
php-fpm
