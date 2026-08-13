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

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

# RUN mkdir -p /var/www/html && \
RUN mkdir -p /var/www/html && \
    php -d memory_limit=512M /usr/local/bin/wp core download --path=/var/www/html --allow-root

RUN chown -R nobody:nobody /var/www/html

COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

WORKDIR /var/www/html

ENTRYPOINT ["/run.sh"]
