FROM alpine:3.23

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY ./tools/mariadb_entry.sh /mariadb_entry.sh

RUN chmod +x /mariadb_entry.sh

ENTRYPOINT ["/mariadb_entry.sh"]
