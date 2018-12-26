#!/bin/sh
docker-compose up -d
echo CPAN mirror running on http://$(docker inspect `./container_id.sh` \
    --format '{{ range .NetworkSettings.Networks}}{{ .IPAddress }}{{end}}')
