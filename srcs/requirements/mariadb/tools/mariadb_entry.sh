#!/bin/sh
set -e

MARIADB_USER_PASSWORD=$(cat /run/secrets/db_password)

echo "========================================"
echo "DataBase variables:"
echo "MARIADB_USER_NAME:          '${MARIADB_USER_NAME}'"
echo "MARIADB_DATABASE_NAME:      '${MARIADB_DATABASE_NAME}'"
echo "MARIADB_USER_PASSWORD:      '${MARIADB_USER_PASSWORD}'"
echo "========================================"

mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

	/usr/bin/mariadbd --user=mysql --bootstrap --skip-name-resolve << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE_NAME}\`;
CREATE USER IF NOT EXISTS '${MARIADB_USER_NAME}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';
GRANT ALL ON \`${MARIADB_DATABASE_NAME}\`.* TO '${MARIADB_USER_NAME}'@'%';
FLUSH PRIVILEGES;
EOF

fi

exec /usr/bin/mariadbd --user=mysql --skip-networking=0 --bind-address=0.0.0.0
