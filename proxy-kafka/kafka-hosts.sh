#!/usr/bin/env sh

/app/kafka-pixy-v0\.11\.1-linux-amd64/kafka-pixy -kafkaPeers  $KAFKA_PROXY_HOSTS -zookeeperPeers $ZOOKEEPER_PROXY_HOSTS

