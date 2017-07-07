FROM jangrewe/gitlab-ci-android

RUN apt-get -qq update
RUN apt-get install -qqy --no-install-recommends \
      software-properties-common python-software-properties

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -qq update
RUN apt-get install -f
RUN apt-get purge oracle-java8-set-default
RUN apt-get install -y --no-install-recommends  oracle-java8-installer git


