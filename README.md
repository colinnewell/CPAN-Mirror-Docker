# CPAN Mini Docker container.

A quick way to setup a mini CPAN mirror using [CPAN::Mini](https://metacpan.org/pod/CPAN::Mini)
on your laptop.

## Initial setup.

The file permissions in the volume need to be fixed up initially.

    docker-compose build
    docker-compose run --rm -u root cpan-mini chown -R cpan.cpan \
        /opt/cpan/minicpan

## Simple running

There are 2 simple shell scripts for day to day running that do
what they say on the tin.

    ./run_mirror.sh
    ./update_mirror.sh

The raw commands used are documented below.

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
        --format '{{ range .Mounts }}{{ if eq .Destination "/opt/cpan/minicpan" }}{{ .Source }}{{ end }}{{ end }}'
