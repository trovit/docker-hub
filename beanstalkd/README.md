# beanstalkd
Beanstalkd image for docker. [Beanstalk](http://kr.github.io/beanstalkd/) is a simple, fast work queue.

This project includes a special image for development purposes that it includes [beanstool](https://github.com/src-d/beanstool), a useful admin tool.

### Docker
To init a container of Trovit beanstalkd is so easy:

```
$ docker run -d trovit/beanstalkd:latest
```

Also you can use `docker-compose.yml`:

```
beanstalkd:
  image: trovit/beanstalkd:latest
  container_name: beanstalkd
  volumes:
    - data:/var/lib/beanstalkd

volumes:
  data
```

The example above uses a volume for persisting queued messages when you destroy/create
the container. If you don't need this, only remove the volume setting.

### Development
We recommend to use the dev version in development environments. You can use this
adding the suffix `-dev` in the image tag name.

```
$ docker run -d trovit/beanstalkd:latest-dev
```

Development version includes the beanstool which you can get stats, push/peek/delete
messages, bury/kick status or tail a tube. For example:

```
$ docker exec -it beanstalkd beanstool stats

+---------+----------+----------+----------+----------+----------+---------+-------+
| Name    | Buried   | Delayed  | Ready    | Reserved | Urgent   | Waiting | Total |
+---------+----------+----------+----------+----------+----------+---------+-------+
| foo     | 20       | 0        | 5        | 0        | 0        | 0       | 28    |
| default | 0        | 0        | 0        | 0        | 0        | 0       | 0     |
+---------+----------+----------+----------+----------+----------+---------+-------+
```

More info about beanstool in his project's url: https://github.com/src-d/beanstool
