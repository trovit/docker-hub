FROM debian:wheezy

RUN apt-get update && apt-get install -y --no-install-recommends \
    gearman-job-server \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 4730

ENTRYPOINT [ "gearmand" ]