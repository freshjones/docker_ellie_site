# Set the base image to debian
FROM debian:jessie

# File Author / Maintainer
MAINTAINER William Jones <billy@freshjones.com>

# Update the repository sources list
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    curl \
    nano \
    git \
    nginx \
    supervisor

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

#RUN find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

#copy supervisor conf
COPY supervisor/supervisor.conf /etc/supervisor/conf.d/supervisord.conf

# Create log directories
RUN mkdir -p /var/log/supervisor

# set daemon to off
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

#add sites enabled dir
ADD sites-enabled/ /etc/nginx/sites-enabled/

COPY app/ /app/
RUN chown -R www-data:www-data /app/storage

VOLUME /app/storage

# clean apt cache
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#expose port 80
EXPOSE 80

#start supervisor
CMD ["/usr/bin/supervisord"]
