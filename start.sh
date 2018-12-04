#!/bin/bash

### Run
eval $(docker-machine env manager)
NODE=$(docker service ps --format "{{.Node}}" scalaRecommender_namenode)
eval $(docker-machine env $NODE)
#CONTAINER_ID_NODE=$(docker ps --filter name=namenode --format "{{.ID}}")
#docker exec $CONTAINER_ID_NODE hadoop fs -copyFromLocal /datasetFiles /
MASTER=$(docker service ps --format "{{.Node}}" scalaRecommender_master)
eval $(docker-machine env $MASTER)
CONTAINER_ID_MASTER=$(docker ps --filter name=master --format "{{.ID}}")
docker exec -it $CONTAINER_ID_MASTER spark-submit --master spark://10.0.1.3:7077 --class bdfi.lab.recommenderproject.RunRecommender /ScalaRecommender/target/scala-2.11/recommender_2.11-2.0.0.jar
#docker exec -it $(docker ps --filter name=master --format "{{.ID}}") spark-submit --master spark://10.0.1.3:7077 --class bdfi.lab.recommenderproject.RunRecommender /ScalaRecommender/target/scala-2.11/recommender_2.11-2.0.0.jar
