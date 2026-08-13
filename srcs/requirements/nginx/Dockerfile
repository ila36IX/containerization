FROM alpine:3.24

RUN apk update && apk add --no-cache nginx openssl

COPY conf/default.conf /etc/nginx/http.d/default.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log

RUN ln -sf /dev/stderr /var/log/nginx/error.log

# NOTE: docker run <container-name> -t executes nginx -t (testing the configuration without
# starting the server)

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
