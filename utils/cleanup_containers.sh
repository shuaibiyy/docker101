#!/bin/bash

# Clean up containers that have been running up to 2 hours
sudo docker ps -a --no-trunc | grep 'hours ago' | awk '{print $1}' | xargs --no-run-if-empty sudo docker stop
sudo docker ps -a --no-trunc | grep 'Exit' | awk '{print $1}' | xargs --no-run-if-empty sudo docker rm
