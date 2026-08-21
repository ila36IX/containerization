#!/bin/sh

set -e

sed -i "s@WORDPRESS_PATH@$WORDPRESS_PATH@" /etc/nginx/http.d/default.conf

cat /etc/nginx/http.d/default.conf

exec nginx -g "daemon off;"
