#!/bin/sh
docker-compose up -d
echo CPAN mirror running on http://$(docker inspect cpanmirrordocker_nginx_1 \
    --format '{{ range .NetworkSettings.Networks}}{{ .IPAddress }}{{end}}')
