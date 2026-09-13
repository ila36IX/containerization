FROM alpine:3.23

RUN apk update && apk add --no-cache lighttpd

# Transfer configuration and static files
COPY conf/lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY code/ /var/code/

# Enforce strict ownership matching the server daemon
RUN chown -R lighttpd:lighttpd /var/code/

EXPOSE 80

ENTRYPOINT ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
