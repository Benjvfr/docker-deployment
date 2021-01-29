FROM haproxy:2.3.4-alpine

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
