#!/bin/sh
set -e

MARIADB_HOST="${MARIADB_HOST:-mariadb}"
MARIADB_USER_NAME="${MARIADB_USER_NAME:-liri}"
MARIADB_USER_DATABASE="${MARIADB_USER_DATABASE:-wordpress}"

MARIADB_USER_PASSWORD=${MARIADB_USER_PASSWORD:-$(cat "${MARIADB_USER_PASSWORD_FILE:-/dev/null}")}
WP_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD:-$(cat "${WP_ADMIN_PASSWORD_FILE:-/dev/null}")}
WP_USER_PASSWORD=${WP_USER_PASSWORD:-$(cat "${WP_USER_PASSWORD_FILE:-/dev/null}")}

sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php84/php-fpm.d/www.conf

echo "Waiting for MariaDB to be ready..."
while ! mariadb-admin ping -h"${MARIADB_HOST}" -u"${MARIADB_USER_NAME}" -p"${MARIADB_USER_PASSWORD}" --silent; do
	sleep 2
done
echo "MariaDB is ready!"

if [ ! -f "/var/www/html/wp-config.php" ]; then

	wp config create \
		--dbname="${MARIADB_USER_DATABASE}" \
		--dbuser="${MARIADB_USER_NAME}" \
		--dbpass="${MARIADB_USER_PASSWORD}" \
		--dbhost="${MARIADB_HOST}" \
		--path="/var/www/html" \
		--allow-root

	wp core install \
		--url="${WP_URL}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--path="/var/www/html" \
		--allow-root

	wp user create \
		"${WP_USER}" \
		"${WP_USER_EMAIL}" \
		--user_pass="${WP_USER_PASSWORD}" \
		--role=author \
		--path="/var/www/html" \
		--allow-root
fi

exec /usr/sbin/php-fpm84 -F
