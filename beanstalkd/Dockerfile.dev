FROM alpine:edge

RUN apk update && apk add --no-cache beanstalkd && apk add curl

RUN cd /tmp && \
        curl -LS https://github.com/tyba/beanstool/releases/download/v0.2.0/beanstool_v0.2.0_linux_amd64.tar.gz | tar -zxv  && \
        cp beanstool_v0.2.0_linux_amd64/beanstool /usr/local/bin/

VOLUME ["/wal"]

EXPOSE 11300

CMD ["/usr/bin/beanstalkd", "-b", "/wal", "-f", "0"]
