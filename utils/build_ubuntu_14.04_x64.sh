#!/bin/bash

# Install and setup docker:
curl -sSL https://get.docker.com/ubuntu/ | sudo sh
# Check:
docker --version
# To ease the pain of specifying sudo everytime:
echo "alias docker='sudo docker'" >> ~/.bashrc
# Allow docker client to connect to insecure registries:
sudo sed -i 's/^#DOCKER_OPTS=.*/DOCKER_OPTS=\"--bip=172.17.42.1/16 --dns=10.0.66.10 --dns=172.17.42.1\"/g' /etc/default/docker
# Restart docker daemon to reflect changed DOCKER_OPTS:
sudo kill -9 $(ps aux | grep 'docker' | awk '{print $2}')
# Make is required when building ubuntu base-image
sudo apt-get install -y make