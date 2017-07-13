FROM trovit/beanstalkd

RUN apk update && apk add --no-cache curl; \
    curl -LS https://github.com/tyba/beanstool/releases/download/v0.2.0/beanstool_v0.2.0_linux_amd64.tar.gz | \
    tar -zxv  -C /usr/local/bin/

VOLUME ["/var/lib/beanstalkd"]

EXPOSE 11300

CMD ["/usr/bin/beanstalkd", "-b", "/var/lib/beanstalkd", "-f", "0"]
