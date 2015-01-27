#!/bin/bash

/usr/bin/mysqld_safe --skip-syslog &
sleep 10s

mysqladmin -u root password welcome
mysql -uroot -pwelcome -e "CREATE DATABASE elliesite;"
mysql -uroot -pwelcome -e "GRANT ALL PRIVILEGES ON elliesite.* TO 'admin'@'localhost' IDENTIFIED BY 'welcome'; FLUSH PRIVILEGES;"

echo "cd into app"
cd /app/laravel

echo "run migration script"
php artisan migrate

mysqladmin -uroot -pwelcome shutdown
