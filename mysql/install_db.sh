#!/bin/bash

/usr/bin/mysqld_safe --skip-syslog &
sleep 10s

mysqladmin -u root password welcome
mysql -uroot -pwelcome -e "CREATE DATABASE elliesite;"
mysql -uroot -pwelcome -e "GRANT ALL PRIVILEGES ON elliesite.* TO 'admin'@'localhost' IDENTIFIED BY 'welcome'; FLUSH PRIVILEGES;"

echo "populate the default database"
mysql -uroot -pwelcome elliesite < /scripts/sql/elliesite.sql

mysql -uroot -pwelcome -e "INSERT INTO `variables` (`name`, `value`)VALUES ('site_color', '$SITE_COLOR'),('site_name', '$SITE_NAME'),('site_template', '$SITE_TEMPLATE');"

#echo "cd into app"
#cd /app/laravel

#echo "run migration script"
#php artisan migrate

#echo "run seed script"
#php artisan db:seed

mysqladmin -uroot -pwelcome shutdown
