#!/bin/sh
set -e

MARIADB_PASSWORD=$(cat "/run/secrets/db_password")
WORDPRESS_ADMIN_PASSWORD=$(cat "/run/secrets/wp_admin_password")
WORDPRESS_AUTHER_PASSWORD=$(cat "/run/secrets/wp_auther_password")

chown nobody:nobody "${WORDPRESS_PATH}"

wp-cli() {
	# NOTE: https://make.wordpress.org/cli/handbook/references/config/#environment-variables
	WP_CLI_CACHE_DIR=/tmp/.wp-cli-cache \
		su-exec nobody /usr/local/bin/wp --path="$WORDPRESS_PATH" "$@";
}
echo "This part???";

if [ ! -f "${WORDPRESS_PATH}/wp-config.php" ]; then
	while ! mariadb-admin ping -h"${MARIADB_HOST}" -u"${MARIADB_USER_NAME}" -p"${MARIADB_PASSWORD}" --silent; do
		sleep 2
	done

	wp-cli  config create \
		--dbname="${MARIADB_DATABASE_NAME}" \
		--dbuser="${MARIADB_USER_NAME}" \
		--dbpass="${MARIADB_PASSWORD}" \
		--dbhost="${MARIADB_HOST}";

	wp-cli core install \
		--url="${WORDPRESS_URL}" \
		--title="${WORDPRESS_TITLE}" \
		--admin_user="${WORDPRESS_ADMIN_USER_NAME}" \
		--admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
		--admin_email="${WORDPRESS_ADMIN_EMAIL}";

	wp-cli user create \
		"${WORDPRESS_AUTHER_NAME}" \
		"${WORDPRESS_AUTHER_EMAIL}" \
		--user_pass="${WORDPRESS_AUTHER_PASSWORD}" \
		--role=author;

	# Redis setup: https://github.com/rhubarbgroup/redis-cache/blob/develop/INSTALL.md
	wp-cli config set WP_REDIS_HOST "$REDIS_HOST"
	wp-cli config set WP_REDIS_PORT "$REDIS_PORT"
	wp-cli plugin install redis-cache --activate
	wp-cli redis enable
fi

exec /usr/sbin/php-fpm84 -F
