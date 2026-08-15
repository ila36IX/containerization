#!/bin/sh
set -e

FTP_USERNAME="ftpadmin"
FTP_PASSWORD="!@#"
FTP_DIRECTORY="/var/www/html"


adduser -h "$FTP_DIRECTORY" -s /sbin/nologin -D "$FTP_USERNAME"
echo "$FTP_USERNAME:$FTP_PASSWORD" | chpasswd

usermod -d $FTP_DIRECTORY -s /sbin/nologin nobody

chown -R nobody:nobody "$FTP_DIRECTORY"
chmod 755 "$FTP_DIRECTORY"

mkdir -p /etc/vsftpd

echo "$FTP_USERNAME" > /etc/vsftpd.user_list

exec vsftpd "/etc/vsftpd/vsftpd.conf"
