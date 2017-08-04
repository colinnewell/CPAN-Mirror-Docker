FROM debian:stretch
MAINTAINER colin.newell@gmail.com

RUN apt-get update && apt-get -y upgrade \
 && apt-get install -y build-essential rsync perl cpanminus
RUN cpanm CPAN::Mini

RUN groupadd -r cpan && useradd -d /opt/cpan -r -g cpan cpan
VOLUME /opt/cpan/minicpan

COPY minicpan /opt/cpan/.minicpanrc

USER cpan
WORKDIR /opt/cpan
