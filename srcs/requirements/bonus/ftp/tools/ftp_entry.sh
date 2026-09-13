#!/bin/sh
set -e

FTP_PASSWORD="$(cat /run/secrets/ftp_password)"

if ! id -u "$FTP_USERNAME" > /dev/null 2>&1; then
    adduser -h $FTP_DIRECTORY -s /sbin/nologin -D $FTP_USERNAME
fi

echo $FTP_USERNAME:$FTP_PASSWORD | chpasswd

chown -R $FTP_USERNAME:$FTP_USERNAME $FTP_DIRECTORY

mkdir -p /etc/vsftpd

exec vsftpd "/etc/vsftpd/vsftpd.conf"
