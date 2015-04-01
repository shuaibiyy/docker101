#!/bin/bash

# Make sure aufs support is available:
sudo aptitude update
sudo aptitude install linux-image-extra-`uname -r`
# Add docker repository key to apt-key for package verification:
sudo sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"
# Add the docker repository to aptitude sources:
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
# Update the repository with the new addition:
sudo aptitude update
# Download and install docker:
sudo aptitude install lxc-docker
# Enable forwarding with UFW (UFW: Uncomplicated Firewall):
sudo sed -i 's/^DEFAULT_FORWARD_POLICY=.*/DEFAULT_FORWARD_POLICY=\"ACCEPT\"/g' /etc/default/ufw
# Reload the UFW:
sudo ufw reload
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