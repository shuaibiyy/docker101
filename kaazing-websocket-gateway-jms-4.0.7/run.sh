#!/bin/bash

sudo docker run -id -p=8000:8000 -p=8001:8001 --name gateway -e DNSDOCK_IMAGE=demo demo/kaazing-jms-gateway-4.0.7