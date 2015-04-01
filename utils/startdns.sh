#!/bin/bash

# This script starts up dnsdock: https://github.com/tonistiigi/dnsdock

# To setup the daemon to work with the DNS, you must make the following change depending on your environment

# If you're on a linux machine
#sudo sed -i 's/^#DOCKER_OPTS=.*/DOCKER_OPTS=\"--bip=172.17.42.1/16 --dns=10.0.66.10 --dns=172.17.42.1\" /g' /etc/default/docker

# If you're using boot2docker, add this to /var/lib/boot2docker/profile
#EXTRA_ARGS="--bip=172.17.42.1/16 --dns=10.0.66.10 --dns=172.17.42.1"

# Start up dns
sudo docker run -d -v /var/run/docker.sock:/var/run/docker.sock --name dnsdock -p 172.17.42.1:53:53/udp tonistiigi/dnsdock -domain kaazing.test
