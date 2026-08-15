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
    php84-tokenizer \
    tar \
    su-exec \
    mariadb-client


RUN ln -s /usr/bin/php84 /usr/bin/php

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php84/php-fpm.d/www.conf

RUN mkdir -p /var/www/html && chown nobody:nobody /var/www/html

# INFO: https://github.com/wp-cli/wp-cli#installing
ADD --checksum=sha256:ce34ddd838f7351d6759068d09793f26755463b4a4610a5a5c0a97b68220d85c \
    --chmod=755 \
    https://github.com/wp-cli/wp-cli/releases/download/v2.12.0/wp-cli-2.12.0.phar \
     /usr/local/bin/wp

RUN su-exec nobody php -d memory_limit=512M /usr/local/bin/wp core download --path=/var/www/html

COPY --chmod=755 tools/wordpress_entry.sh /wordpress_entry.sh

ENTRYPOINT ["/wordpress_entry.sh"]
