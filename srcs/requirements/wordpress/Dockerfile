FROM alpine:3.24

RUN apk update && apk add --no-cache \
    php84 \
    php84-fpm \
    php84-mysqli \
    php84-json \
    php84-curl \
    php84-dom \
    php84-exif \
    php84-fileinfo \
    php84-mbstring \
    php84-openssl \
    php84-xml \
    php84-zip \
    php84-phar \
    wget \
    tar \
    mariadb-client


RUN ln -s /usr/bin/php84 /usr/bin/php

RUN mkdir -p /var/www/html

RUN chown -R nobody:nobody /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp

RUN chmod +x /usr/local/bin/wp

RUN php -d memory_limit=512M /usr/local/bin/wp core download --path=/var/www/html --allow-root

COPY ./tools/wordpress_entry.sh /wordpress_entry.sh

RUN chmod +x /wordpress_entry.sh

ENTRYPOINT ["/wordpress_entry.sh"]
