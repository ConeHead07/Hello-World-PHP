#!/bin/bash

# Baue das Image (z.B. docker build -t my-php-app .)
docker build -t my-php-app .

Verwende my-php-app statt php:8.2-fpm in deiner Pipeline.