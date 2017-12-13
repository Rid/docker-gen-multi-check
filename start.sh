#!/bin/sh

set -eu pipefail

echo "Attempting to connect to server-dnsmasq.server-cylo"
until ping -c 1 server-dnsmasq.server-cylo; do
    printf '.'
    sleep 5
done
echo "Attempting to connect to nginx-php-serverapi.server-cylo"
until ping -c 1 nginx-php-serverapi.server-cylo; do
    printf '.'
    sleep 5
done
echo "Attempting to connect to letsencrypt-nginx-proxy-companion-multi.server-cylo"
until ping -c 1 letsencrypt-nginx-proxy-companion-multi.server-cylo; do
    printf '.'
    sleep 5
done
echo "Attempting to connect to server-postgresql.server-cylo"
until ping -c 1 server-nginx-proxy.server-cylo; do
    printf '.'
    sleep 5
done
echo "Was able to connect to all"

echo "/usr/local/bin/docker-gen -endpoints ${DOCKER_GEN_ENDPOINTS} -wait 5s:30s -notify-sighup server-nginx-proxy.server-cylo -watch /etc/docker-gen/templates/nginx.tmpl /etc/nginx/conf.d/default.conf"
/usr/local/bin/docker-gen -endpoints ${DOCKER_GEN_ENDPOINTS} -wait 5s:30s -notify-sighup server-nginx-proxy.server-cylo -watch /etc/docker-gen/templates/nginx.tmpl /etc/nginx/conf.d/default.conf