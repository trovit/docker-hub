FROM ubuntu:16.04

RUN  apt-get update \
&& apt-get install -y wget \
&& rm -rf /var/lib/apt/lists/* \
&& wget https://github.com/mailgun/kafka-pixy/releases/download/v0.11.1/kafka-pixy-v0.11.1-linux-amd64.tar.gz \
&& tar xzf kafka-pixy-v0.11.1-linux-amd64.tar.gz \
&& cd kafka-pixy-v0.11.1-linux-amd64/ \
&& ./kafka-pixy -kafkaPeers ${KAFKA_PROXY_HOSTS} -zookeeperPeers ${ZOOKEEPER_PROXY_HOSTS}




