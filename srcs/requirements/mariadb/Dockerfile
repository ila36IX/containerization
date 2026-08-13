FROM alpine:3.24

RUN apk update && apk add --no-cache mariadb mariadb-client dumb-init

COPY ./tools/run.sh /run.sh

RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
