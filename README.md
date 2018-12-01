# ScalaRecommender
Music recommender system built for university course on Big Data infrastructure

# Run in docker swarm

1 Run "prepare.sh"

2 Wait until every replica service is up and running. To check their status run docker-machine ssh manager "docker service ls"

3 Run "start.sh"

# Known issues

1 hdfs nodes don't have visibility: ping is working but telnet to ports is not, so it's probably a port mapping issue

# Additional information

1 To clean ALL containers, images and docker-machines, just run:
```
clean.sh
```
