# Android-CI for Docker

Android-CI for Docker improves the [gitlab-ci-android image](https://hub.docker.com/r/jangrewe/gitlab-ci-android/) 
adding the Oracle's Java 8 and Git.

This project is part of the [Trovit's Docker Hub account](https://hub.docker.com/r/trovit/).

## Installation

To use this docker image in your Gitlab CI system you need to add a .gitlab-ci.yml, this will launch a full build of your app, with lint and testing included. 

A sample of content could be:

```
image: trovit/android-ci

before_script:
- export GRADLE_USER_HOME=$(pwd)/.gradle
- chmod +x ./gradlew

cache:
  key: ${CI_PROJECT_ID}
  paths:
  - .gradle/

stages:
  - build

build:
  stage: build
  script:
    - ./gradlew build
  artifacts:
    paths:
    - app/build/outputs/
```

## Parties

[GitLab](https://about.gitlab.com/) is a service-as-service (SASS) that provides Git repository management, code reviews, issue 
tracking, activity feeds and wikis. Optionally, GitLab can be installed in your own bare-metal.

[Docker](https://www.docker.com/) is an open platform for developers and sysadmins to build, ship and run distributed applications,
whether on laptops, data center VM, or the cloud.

