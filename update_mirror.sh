#!/bin/sh
docker-compose run --rm cpan-mini /usr/local/bin/minicpan -d 0755
echo Finished updating the mirror in $(docker inspect `./container_id.sh` \
    --format '{{ range .Mounts }}{{ if eq .Destination "/opt/cpan/minicpan" }}{{ .Source }}{{ end }}{{ end }}')
