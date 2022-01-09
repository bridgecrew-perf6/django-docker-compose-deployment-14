#!/bin/sh

set -e

envsubst < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf

# recommended way of running nginx in docker : RUN IT IN foreground
nginx -g "daemon off;"