#!/bin/bash

#start mysql
/usr/bin/mysqld_safe --skip-syslog &
sleep 10s

echo "cd into app"
cd /app/laravel

echo "add some variables to the .env file"
echo -e "SITE_NAME=$SITE_NAME" >> .env
echo -e "SITE_TEMPLATE=$SITE_TEMPLATE" >> .env
echo -e "SITE_COLOR=$SITE_COLOR" >> .env

#run migration script
php artisan db:seed

#shutdown the mysql server
mysqladmin -uroot -pwelcome shutdown

# start all the services
/usr/local/bin/supervisord -n