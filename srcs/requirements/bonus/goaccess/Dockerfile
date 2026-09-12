FROM alpine:3.23

RUN apk update && apk add --no-cache lighttpd goaccess tini

WORKDIR /srv/report

COPY conf/lighttpd.conf /etc/lighttpd/lighttpd.conf

COPY --chmod=755 tools/go_access_entry.sh /go_access_entry.sh

ENTRYPOINT ["tini", "--"]
CMD ["/go_access_entry.sh"]
