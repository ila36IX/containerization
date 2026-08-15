#!/bin/sh
set -e

FTP_PASSWORD="$(cat $FTP_PASSWORD_FILE)"

if ! id "$FTP_USERNAME" >/dev/null 2>&1; then
    adduser -h "$FTP_DIRECTORY" -s /sbin/nologin -D "$FTP_USERNAME"
fi

echo "$FTP_USERNAME:$FTP_PASSWORD" | chpasswd

usermod -d $FTP_DIRECTORY -s /sbin/nologin nobody

chown -R nobody:nobody "$FTP_DIRECTORY"
chmod 755 "$FTP_DIRECTORY"

mkdir -p /etc/vsftpd

echo "$FTP_USERNAME" > /etc/vsftpd.user_list

exec vsftpd "/etc/vsftpd/vsftpd.conf"
