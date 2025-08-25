FROM php:8.2-fpm

RUN apt-get update && \
    apt-get install -y unzip git zip && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    rm composer-setup.php