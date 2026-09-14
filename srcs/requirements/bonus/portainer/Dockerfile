FROM alpine:3.23

RUN apk update && apk add --no-cache tar libc6-compat

ADD https://github.com/portainer/portainer/releases/download/2.27.6/portainer-2.27.6-linux-amd64.tar.gz portainer.tar.gz

RUN mkdir /portainer
RUN tar -xvf portainer.tar.gz -C /portainer --strip-components=1

CMD ["/portainer/portainer"]
