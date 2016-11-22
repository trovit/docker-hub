# Trovit Dockerfile hub
This project is part of the [Trovit Docker Hub](https://hub.docker.com/r/trovit/) account.

Below you can find a collection of docker images created by the Trovit Tech Team. Feel free
to comment, suggest or collaborate anything.

| Image              | Tag  | Description                                                                                         |
|--------------------|------|-----------------------------------------------------------------------------------------------------|
| trovit/beanstalkd  | prod | A light beanstalkd server based in *Alpine*.                                                        |
| trovit/beanstalkd  | dev  | Include beanstool cli tool. Type `beanstool -h` to get a complete list of available commands.       |
| trovit/php-kafka   | prod | PHP-FPM 7.0 daemon with `php7-rdkafka` extension enabled.                                              |
| trovit/php-kafka   | dev  | PHP-FPM 7.0 tweaked for development (including composer, xdebug, profiler, SSH) with php-kafka extension enabled. |


###Example of use:
Up any container locally running the next command in your project root path:

```$ docker run -it -d --name=php-kafka -v $PWD:/app -v ~/.ssh:/root/.ssh -p "2222:22" trovit/php-kafka:dev```

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
        image: trovit/php-kafka:dev
        container_name: php-kafka
        volumes:
            - $PWD:/app
            - ~/.ssh:/root/.ssh
        ports:
            - "2222:22"
```

Welcome to our Docker playground!!