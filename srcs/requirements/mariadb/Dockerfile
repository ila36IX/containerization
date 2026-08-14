FROM alpine:3.24

RUN apk update && apk add --no-cache mariadb mariadb-client dumb-init

COPY ./tools/mariadb_entry.sh /mariadb_entry.sh

RUN chmod +x /mariadb_entry.sh

ENTRYPOINT ["/mariadb_entry.sh"]
