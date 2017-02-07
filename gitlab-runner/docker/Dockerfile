FROM gitlab/gitlab-runner:alpine


ENV GLIBC_VERSION 2.23-r3
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.13.0
ENV DOCKER_SHA256 fc194bb95640b1396283e5b23b5ff9d1b69a5e418b5b3d774f303a7642162ad6
ENV DOCKER_COMPOSE_VERSION 1.10.0
ENV GITLAB_USER_UID 995
ENV DOCKER_GROUP_UID 995


RUN wget -qO /etc/apk/keys/sgerrand.rsa.pub "https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub" \
    && wget -qO glibc.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" \
    && apk add glibc.apk \
    && wget -qO glibc-bin.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" \
    && apk add glibc-bin.apk \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
    && wget -qO docker.tgz "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" \
    && echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
    && tar -xzvf docker.tgz \
    && mv docker/* /usr/bin/ \
    && rmdir docker \
    && rm docker.tgz \
    && docker -v \
    && wget -qO /usr/bin/docker-compose "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
    && chmod +x /usr/bin/docker-compose \
    && rm -rf glibc.apk glibc-bin.apk /var/cache/apk/* \
    && addgroup -g ${DOCKER_GROUP_UID} -S docker \
    && adduser -D -h /home/gitlab-runner -u ${GITLAB_USER_UID} -G docker -s /bin/bash gitlab-runner \
    && chown root:docker /usr/bin/docker* \
    && chown gitlab-runner /home/gitlab-runner \
    && id gitlab-runner \
    && apk add --update openssh-client \
    && rm -rf /var/cache/apk/*
