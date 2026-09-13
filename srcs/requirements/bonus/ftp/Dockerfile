FROM alpine:3.23

RUN apk add --no-cache vsftpd shadow tini

COPY ./conf/ftp.conf /etc/vsftpd/vsftpd.conf

COPY ./tools/ftp_entry.sh /ftp_entry.sh
RUN chmod +x /ftp_entry.sh

CMD ["tini", "--", "/ftp_entry.sh"]
