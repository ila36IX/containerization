FROM alpine:3.24

RUN apk add --no-cache vsftpd tini shadow

COPY ./conf/ftp.conf /etc/vsftpd/vsftpd.conf

COPY --chmod=755 ./tools/ftp_entry.sh /ftp_entry.sh

CMD ["tini", "--", "/ftp_entry.sh"]
