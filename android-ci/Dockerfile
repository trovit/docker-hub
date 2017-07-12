FROM jangrewe/gitlab-ci-android

RUN apt-get -qq update \
    && apt-get install -qqy --no-install-recommends software-properties-common python-software-properties \
    && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
    && add-apt-repository ppa:webupd8team/java \
    && apt-get -qq update \
    && apt-get install -y --no-install-recommends  oracle-java8-installer git \
    && rm -rf /var/lib/apt/lists/*
