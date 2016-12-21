FROM gitlab/gitlab-runner:alpine

ENV GITLAB_USER_UID 995
ENV DOCKER_GROUP_UID 995
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.12.5
ENV DOCKER_SHA256 0058867ac46a1eba283e2441b1bb5455df846144f9d9ba079e97655399d4a2c6
ENV DOCKER_COMPOSE_VERSION 1.9.0

RUN apk add --no-cache \
		ca-certificates \
		curl \
		openssl \
    && set -x \
	&& curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v \
    && curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/run.sh > /usr/bin/docker-compose \
    && chmod +x /usr/bin/docker-compose \
    && addgroup -g ${DOCKER_GROUP_UID} -S docker \
    && adduser -D -h /home/gitlab-runner -u ${GITLAB_USER_UID} -G docker -s /bin/bash gitlab-runner \
    && chown root:docker /usr/bin/docker* \
    && id gitlab-runner
