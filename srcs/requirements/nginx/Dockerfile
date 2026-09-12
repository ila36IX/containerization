FROM alpine:3.23

RUN apk update && apk add --no-cache nginx openssl

COPY conf/default.conf /etc/nginx/http.d/default.conf

# RUN ln -sf /dev/stdout /var/log/nginx/access.log
# RUN ln -sf /dev/stderr /var/log/nginx/error.log

COPY tools/nginx_entry.sh /nginx_entry.sh
RUN chmod +x /nginx_entry.sh

CMD ["/nginx_entry.sh"]
