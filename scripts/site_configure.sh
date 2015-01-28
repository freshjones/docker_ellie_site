#!/bin/bash

SITENAME=$1
SITECOLOR=$2
SITETEMPLATE=$3

echo "cd into app"
cd /app/laravel

echo "run laravel site initialize"
php artisan site:initialize "$SITENAME" "$SITECOLOR" "$SITETEMPLATE"
