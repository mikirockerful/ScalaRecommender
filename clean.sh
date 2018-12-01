#!/bin/bash

# Leave docker swarm 
docker swarm leave --force
# Remove docker-machines
docker-machine rm -f $(docker-machine ls -q)
# Stop and remove all containers
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
# Remove all images
docker rmi -f $(docker images -a -q)
