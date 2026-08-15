FROM alpine:3.24

RUN apk update && apk add --no-cache \
    php84 \
    php84-fpm \
    php84-mysqli \
    php84-session

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php84/php-fpm.d/www.conf

ADD --checksum=sha256:c820771612aedd70b26b8f75f442cc9fc118f8225d0166cc6c5909a89f314805 \
    https://github.com/vrana/adminer/releases/download/v6.0.1/adminer-6.0.1-en.php \
     /var/index.php

RUN chown -R nobody:nobody /var/index.php

ENTRYPOINT ["/usr/sbin/php-fpm84", "-F"]
