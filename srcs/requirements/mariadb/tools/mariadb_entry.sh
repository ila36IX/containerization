#!/bin/sh
set -e

MARIADB_ROOT_PASSWORD=$(cat "${MARIADB_ROOT_PASSWORD_FILE:-/dev/null}")
MARIADB_USER_PASSWORD=$(cat "${MARIADB_USER_PASSWORD_FILE:-/dev/null}")

# NOTE: This can be useful in case of trying to use this dockerfile alone
# MARIADB_USER_NAME="${MARIADB_USER_NAME:-user}"
# MARIADB_USER_DATABASE="${MARIADB_USER_DATABASE:-userdb}"
# MARIADB_ROOT_PASSWORD="${MARIADB_ROOT_PASSWORD:-root}"
# MARIADB_USER_PASSWORD="${MARIADB_USER_PASSWORD:-user}"

echo "========================================"
echo "DataBase variables:"
echo "MARIADB_USER_NAME:          '${MARIADB_USER_NAME}'"
echo "MARIADB_USER_DATABASE:      '${MARIADB_USER_DATABASE}'"
echo "MARIADB_ROOT_PASSWORD:      '${MARIADB_ROOT_PASSWORD}'"
echo "MARIADB_USER_PASSWORD:      '${MARIADB_USER_PASSWORD}'"
echo "========================================"

mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

	/usr/bin/mariadbd --user=mysql --bootstrap --skip-name-resolve << EOF
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}' WITH GRANT OPTION;
CREATE DATABASE IF NOT EXISTS \`${MARIADB_USER_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MARIADB_USER_NAME}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';
GRANT ALL ON \`${MARIADB_USER_DATABASE}\`.* TO '${MARIADB_USER_NAME}'@'%';
FLUSH PRIVILEGES;
EOF

fi

exec /usr/bin/mariadbd --user=mysql --skip-networking=0 --bind-address=0.0.0.0
