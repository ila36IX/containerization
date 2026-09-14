FROM alpine:3.23

RUN apk update && apk add --no-cache nginx openssl

COPY conf/default.conf /etc/nginx/http.d/default.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

ARG DOMAIN_NAME
ENV DOMAIN_NAME=${DOMAIN_NAME}

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/C=MA/ST=Marrakech/L=bengrr/O=42/CN=$DOMAIN_NAME"

COPY tools/nginx_entry.sh /nginx_entry.sh
RUN chmod +x /nginx_entry.sh

CMD ["/nginx_entry.sh"]
