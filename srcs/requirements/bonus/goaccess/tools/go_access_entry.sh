#!/bin/sh

while [ ! -f /var/log/nginx/access.log ]; do
  echo "Waiting for Nginx access.log to be created..."
  sleep 2
done

# NOTE: https://goaccess.io/man
goaccess /var/log/nginx/access.log \
  -o /srv/report/index.html \
  --log-format=COMBINED \
  --real-time-html \
  --port=7890 \
  --ws-url=ws://localhost:7890 \
  --daemonize

exec lighttpd -D -f /etc/lighttpd/lighttpd.conf
