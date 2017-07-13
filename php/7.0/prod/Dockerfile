FROM jorge07/alpine-php:7

RUN cp /etc/apk/repositories /tmp \
    && echo "@edge-testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update librdkafka php7-rdkafka@edge-testing \
    && rm -rf /var/cache/apk/* \
    && mv -f /tmp/repositories /etc/apk
