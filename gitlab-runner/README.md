# GitLab-runner for Docker

GitLab-runner for Docker improves the alpine [gitlab-runner image](https://hub.docker.com/r/gitlab/gitlab-runner/) 
adding the *docker* and *docker-compose* binaries.

This project is part of the [Trovit's Docker Hub account](https://hub.docker.com/r/trovit/).

## Installation

The full party begin when you create some service with this image and share the *docker.sock* from your host into the container. 
Be sure to [install docker engine](https://docs.docker.com/engine/installation/) correctly in your host system and create 
a folder for saving the gitlab-runner configuration and sharing the gitlab-runner's home folder:

```
$ mkdir -p /var/gitlab-runner/config
$ mkdir /var/gitlab-runner/home
```

Then, you can start the service:

```
$ docker run -it -d --name gitlab-runner -v /var/run/docker.sock:/var/run/docker.sock -v /var/gitlab-runner/config:/etc/gitlab-runner -v /var/gitlab-runner/home:/home/gitlab-runner trovit/docker-hub:gitlab-runner-docker
```

The first time, you have to register the runner into your GitLab service (if you rebuild your container, it will get the 
previous configuration from the shared config folder):

```
$ export GITLAB=$(sudo docker ps -ql)
$ docker exec -it $GITLAB gitlab-runner register --executor shell --description "GitLab CI"
```

You will be prompted for the URI and token gitlab service. Get them from the page of any project in *GitLab > Settings > Runners*. 
More info [here](https://docs.gitlab.com/ce/user/project/new_ci_build_permissions_model.html).

Next, you could start using the CI capabilities of GitLab following this [demo project](https://github.com/jorge07/ddd-playground/). 
Check the *.gitlab-ci.yml* and *build.xml* files for real examples of CI/CD scripts. 

## Advanced

For a more stable installation, you can thrown up the gitlab-runner app as a `systemd service` instead of `docker run -d`:

```
$ sudo su -
$ touch /etc/systemd/system/docker-gitlab_runner.service
$ echo "[Unit]
Description=Gitlab-runner container
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStartPre=-/usr/bin/docker stop gitlab_runner
ExecStartPre=-/usr/bin/docker rm gitlab_runner
ExecStartPre=/usr/bin/docker pull trovit/docker-hub:gitlab-runner-docker
ExecStart=/usr/bin/docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/gitlab-runner/config:/etc/gitlab-runner -v /var/gitlab-runner/home:/home/gitlab-runner --name gitlab_runner trovit/docker-hub:gitlab-runner-docker
ExecStop=/usr/bin/docker stop -t 2 gitlab_runner
ExecStopPost=/usr/bin/docker rm -f gitlab_runner

[Install]
WantedBy=default.target" > /etc/systemd/system/docker-gitlab_runner.service
$ systemctl daemon-reload
$ systemctl start docker-gitlab_runner.service
$ systemctl enable docker-gitlab_runner.service
```

Now, you can check if the service status is OK:

```
$ sudo systemctl status docker-gitlab_runner1.service
```

## Parties

[GitLab](https://about.gitlab.com/) is a service-as-service (SASS) that provides Git repository management, code reviews, issue 
tracking, activity feeds and wikis. Optionally, GitLab can be installed in your own bare-metal.

[GitLab Runner](https://docs.gitlab.com/runner/) is used to run your jobs and send the results back to GitLab. Is is used
in conjuntion with [GitLab CI](https://about.gitlab.com/gitlab-ci/).

[Docker](https://www.docker.com/) is an open platform for developers and sysadmins to build, ship and run distributed applications,
whether on laptops, data center VM, or the cloud.

