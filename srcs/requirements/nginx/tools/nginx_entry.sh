#!/bin/sh

set -e

sed -i "s@CONFIG_WORDPRESS_PATH@$WORDPRESS_PATH@" /etc/nginx/http.d/default.conf
sed -i "s@CONFIG_DOMAIN_NAME@$DOMAIN_NAME@" /etc/nginx/http.d/default.conf

exec nginx -g "daemon off;"
