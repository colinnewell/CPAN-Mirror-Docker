# CPAN Mini Docker container.

## Initial setup.

The file permissions in the volume need to be fixed up initially.

    docker-compose run --rm -u root cpan-mini chown -r cpan.cpan \
        /opt/cpan/minicpan

## Downloading the modules.

    docker-compose run --rm cpan-mini /usr/local/bin/minicpan -d 0755

## Spinning up the mirror.

    docker-compose up -d

## What IP address?

    docker inspect cpanmirrordocker_nginx_1 \
        --format '{{ range .NetworkSettings.Networks}}{{ .IPAddress }}{{end}}'

## Installing modules

    export CPANMIRROR=$(docker inspect cpanmirrordocker_nginx_1 \
        --format '{{ range .NetworkSettings.Networks}}{{ .IPAddress }}{{end}}')
    cpanm -M http://$CPANMIRROR Jenkins::API

## Figuring out where your volume is

If you're wondering where the files for your mirror are you can run inspect 
to find out.

    docker inspect cpanmirrordocker_nginx_1 \
        --format '{{ range .Mounts }}{{ .Source }}{{ end }}'
