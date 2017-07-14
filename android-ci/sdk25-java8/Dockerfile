FROM jangrewe/gitlab-ci-android

RUN apt-get -qq update \
    && apt-get install -qqy --no-install-recommends software-properties-common python-software-properties \
    && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
    && add-apt-repository ppa:webupd8team/java \
    && apt-get purge -y openjdk-8-jre openjdk-8-jre-headless \
    && apt-get -qq update \
    && apt-get install -y --no-install-recommends  oracle-java8-set-default git \
    && apt-get purge -y software-properties-common python-software-properties \
    && apt-get autoremove -y \
    && /sdk/tools/bin/sdkmanager --update \
    && rm -rf /sdk/emulator/* \
    && rm -rf /sdk/add-ons/* \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
