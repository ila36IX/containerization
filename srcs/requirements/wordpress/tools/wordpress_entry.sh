#!/bin/sh
set -e

MARIADB_USER_PASSWORD=$(cat "${MARIADB_USER_PASSWORD_FILE}")
WP_ADMIN_PASSWORD=$(cat "${WP_ADMIN_PASSWORD_FILE}")
WP_USER_PASSWORD=$(cat "${WP_USER_PASSWORD_FILE}")

chown nobody:nobody /var/www/html

wp-cli() {
	# NOTE: https://make.wordpress.org/cli/handbook/references/config/#environment-variables
	WP_CLI_CACHE_DIR=/tmp/.wp-cli-cache \
		su-exec nobody /usr/local/bin/wp --path="/var/www/html" "$@";
}

if [ ! -f "/var/www/html/wp-config.php" ]; then
	while ! mariadb-admin ping -h"${MARIADB_HOST}" -u"${MARIADB_USER_NAME}" -p"${MARIADB_USER_PASSWORD}" --silent; do
		sleep 2
	done

	wp-cli  config create \
		--dbname="${MARIADB_USER_DATABASE}" \
		--dbuser="${MARIADB_USER_NAME}" \
		--dbpass="${MARIADB_USER_PASSWORD}" \
		--dbhost="${MARIADB_HOST}";


	wp-cli core install \
		--url="${WP_URL}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}";

	wp-cli user create \
		"${WP_USER}" \
		"${WP_USER_EMAIL}" \
		--user_pass="${WP_USER_PASSWORD}" \
		--role=author;

	# Redis setup: https://github.com/rhubarbgroup/redis-cache/blob/develop/INSTALL.md
	wp-cli config set WP_REDIS_HOST "redis"
	wp-cli config set WP_REDIS_PORT "6379"
	wp-cli plugin install redis-cache --activate
	wp-cli redis enable
fi

exec /usr/sbin/php-fpm84 -F
