FROM gitlab/gitlab-runner:latest

RUN groupadd docker \
    && apt-get update \
    && apt-get -y install apt-transport-https ca-certificates \
    && apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-engine \
    && apt-get autoremove \
    && usermod -aG docker gitlab-runner \
    && curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose