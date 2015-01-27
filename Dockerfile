# Set the base image to debian
FROM debian:jessie

# File Author / Maintainer
MAINTAINER William Jones <billy@freshjones.com>

ENV DEBIAN_FRONTEND noninteractive
ENV MYSQL_USER admin
ENV MYSQL_PASS welcome

ENV SITE_NAME="My Local YMCA" \
    SITE_TEMPLATE="3" \
    SITE_COLOR="2"

# Update the repository sources list
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    curl \
    nano \
    git \
    nginx \
    supervisor

#install mysql
RUN apt-get install -y \
    mysql-server

#install php fpm
RUN apt-get -y install -y \
    php5-fpm \
    php5-mysql \ 
    php5-gd \
    php5-memcached \ 
    php5-imap \
    php5-mcrypt \
    php5-xmlrpc

# php-fpm config
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini && \
    sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/fpm/php.ini && \
    sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php5/fpm/php.ini && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf && \
    sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php5/fpm/pool.d/www.conf

#install composer
RUN curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer

#copy supervisor conf
COPY supervisor/supervisor.conf /etc/supervisor/conf.d/supervisord.conf

# Create log directories
RUN mkdir -p /var/log/supervisor

# set daemon to off
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

#add sites enabled dir
ADD nginx/sites-enabled/ /etc/nginx/sites-enabled/

#clone in the app
RUN git clone -b master --single-branch https://github.com/freshjones/ellie_webapp.git /app/laravel

COPY app/storage/ /app/storage/
RUN chown -R www-data:www-data /app/storage

#change permissions on the mysqld folder
#RUN chown -R mysql:mysql /var/lib/mysql/

#install scripts
ADD scripts/ /scripts/

#run install script
RUN chmod +x /scripts/*.sh

#run laravel install
RUN /bin/bash /scripts/laravel_install.sh

#run install db script
RUN /bin/bash /scripts/mysql_istall.sh

# clean apt cache
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/app/storage","/var/lib/mysql"]

#expose port 80
EXPOSE 80

#start supervisor
CMD ["/usr/bin/supervisord"]
