#!/bin/sh
set -e

MARIADB_USER_PASSWORD=$(cat "${MARIADB_USER_PASSWORD_FILE}")
WP_ADMIN_PASSWORD=$(cat "${WP_ADMIN_PASSWORD_FILE}")
WP_USER_PASSWORD=$(cat "${WP_USER_PASSWORD_FILE}")

sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php84/php-fpm.d/www.conf

echo "Waiting for MariaDB to be ready..."
while ! mariadb-admin ping -h"${MARIADB_HOST}" -u"${MARIADB_USER_NAME}" -p"${MARIADB_USER_PASSWORD}" --silent; do
	sleep 2
done

if [ ! -f "/var/www/html/wp-config.php" ]; then

	wp --allow-root config create \
		--dbname="${MARIADB_USER_DATABASE}" \
		--dbuser="${MARIADB_USER_NAME}" \
		--dbpass="${MARIADB_USER_PASSWORD}" \
		--dbhost="${MARIADB_HOST}" \
		--path="/var/www/html" \
		

	wp --allow-root core install \
		--url="${WP_URL}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--path="/var/www/html" \

	wp --allow-root user create \
		"${WP_USER}" \
		"${WP_USER_EMAIL}" \
		--user_pass="${WP_USER_PASSWORD}" \
		--role=author \
		--path="/var/www/html"
fi

exec /usr/sbin/php-fpm84 -F
