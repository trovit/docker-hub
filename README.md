# Trovit Dockerfile hub
This project is part of the [Trovit's Docker Hub account](https://hub.docker.com/r/trovit/).

Below you can find a collection of docker images created by the Trovit Tech Team. Feel free
to comment, suggest or collaborate anything.

| Image              | Tag  | Description                                                                                         |
|--------------------|------|-----------------------------------------------------------------------------------------------------|
| [trovit/docker-hub:beanstalkd-prod](https://github.com/trovit/docker-hub/blob/master/beanstalkd/Dockerfile.prod)  | prod | A light beanstalkd server based in *Alpine*.                                                        |
| [trovit/docker-hub:beanstalkd-dev](https://github.com/trovit/docker-hub/blob/master/beanstalkd/Dockerfile.dev)  | dev  | Include beanstool cli tool. Type `beanstool -h` to get a complete list of available commands.       |
| [trovit/docker-hub:php-kafka-prod](https://github.com/trovit/docker-hub/blob/master/php-kafka/Dockerfile.prod)   | prod | PHP-FPM 7.0 daemon with `php7-rdkafka` extension enabled.                                              |
| [trovit/docker-hub:php-kafka-dev](https://github.com/trovit/docker-hub/blob/master/php-kafka/Dockerfile.dev)   | dev  | PHP-FPM 7.0 tweaked for development (including composer, xdebug, profiler, SSH) with php-kafka extension enabled. |
| [trovit/docker-hub:proxy-kafka](https://github.com/trovit/docker-hub/blob/master/proxy-kafka/Dockerfile)   | -   | Include the Kafka-Pixy that it is a local aggregating HTTP proxy to Kafka. All based in ubuntu. It is necessary to define two variables KAFKA_PROXY_HOSTS and ZOOKEEPER_PROXY_HOSTS |
| [trovit/docker-hub:gitlab-runner-docker](https://github.com/trovit/docker-hub/blob/master/gitlab-runner/docker/Dockerfile)   | -   | Gilab-runner (CI) for run dockerized projects. We recommend sharing the docker host daemon, gitlab-runner/config folder and certs folders from host to inside container. |
| [trovit/docker-hub:gearman](https://github.com/trovit/docker-hub/blob/master/gearman/Dockerfile)   | -   | A Gearman  0.33 image over debian:wheezy. Exposes port 4730 |

### Example of use:
Up any container locally running the next command in your project root path:

```$ docker run -it -d --name=php-kafka -v $PWD:/app -v ~/.ssh:/root/.ssh -p "2222:22" trovit/docker-hub:php-kafka-dev```

Then you can SSH into:

```$ ssh root@127.0.0.1 -p 2222``` (type `root` as password too)

only if SSH is available. Alternative you can use:
 
```$ docker exec -it php-kafka sh```

or directly execute any command:

```$ docker exec -it php-kafka composer update```

But, if you prefer, you can create a ```docker-compose.yml``` file and save it in your project:

```
version: '2'
services:

    php-kafka:
        image: trovit/docker-hub:php-kafka-dev
        container_name: php-kafka
        volumes:
            - $PWD:/app
            - ~/.ssh:/root/.ssh
        ports:
            - "2222:22"
```

Welcome to our Docker playground!!
