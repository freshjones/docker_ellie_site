#!/bin/bash

/usr/bin/mysqld_safe &
sleep 10s

mysqladmin -u root password welcome
mysql --skip-syslog -uroot -pwelcome -e "CREATE DATABASE elliesite;"
mysql --skip-syslog -uroot -pwelcome -e "GRANT ALL PRIVILEGES ON elliesite.* TO 'admin'@'localhost' IDENTIFIED BY 'welcome'; FLUSH PRIVILEGES;"

#echo "cd into app"
#cd /app/laravel

#echo "run migration script"
#php artisan migrate

#echo "run seed script"
#php artisan db:seed

mysqladmin -uroot -pwelcome shutdown