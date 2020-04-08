#!/bin/bash

composer install

php artisan key:generate
php artisan config:cache
php artisan migrate

# Fix laravel folder permissions

php-fpm
