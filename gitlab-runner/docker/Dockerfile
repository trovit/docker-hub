FROM gitlab/gitlab-runner:alpine


ENV GLIBC_VERSION 2.23-r3
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.12.5
ENV DOCKER_SHA256 0058867ac46a1eba283e2441b1bb5455df846144f9d9ba079e97655399d4a2c6
ENV DOCKER_COMPOSE_VERSION 1.9.0
ENV GITLAB_USER_UID 995
ENV DOCKER_GROUP_UID 995


RUN apk add --update curl \
    && curl -Lo /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
    && curl -Lo glibc.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" \
    && apk add glibc.apk \
    && curl -Lo glibc-bin.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" \
    && apk add glibc-bin.apk \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
    && curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
    && echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
    && tar -xzvf docker.tgz \
    && mv docker/* /usr/bin/ \
    && rmdir docker \
    && rm docker.tgz \
    && docker -v \
    && curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose \
    && chmod +x /usr/bin/docker-compose \
    && apk del curl \
    && rm -rf glibc.apk glibc-bin.apk /var/cache/apk/* \
    && addgroup -g ${DOCKER_GROUP_UID} -S docker \
    && adduser -D -h /home/gitlab-runner -u ${GITLAB_USER_UID} -G docker -s /bin/bash gitlab-runner \
    && chown root:docker /usr/bin/docker* \
    && id gitlab-runner
