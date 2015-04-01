#!/bin/bash

sudo docker rmi $(docker images -a -q)
