#!/bin/bash

# Stop and remove all containers
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
# Remove all images
docker rmi -f $(docker images -a -q)
