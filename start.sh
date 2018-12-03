#!/bin/bash

### Run
eval $(docker-machine env manager)
NODE=$(docker service ps --format "{{.Node}}" scalaRecommender_namenode)
eval $(docker-machine env $NODE)
CONTAINER_ID_NODE=$(docker ps --filter name=namenode --format "{{.ID}}")
docker exec $CONTAINER_ID_NODE hadoop fs -copyFromLocal /datasetFiles /
MASTER=$(docker service ps --format "{{.Node}}" scalaRecommender_master)
eval $(docker-machine env $MASTER)
CONTAINER_ID_MASTER=$(docker ps --filter name=master --format "{{.ID}}")
echo "Cointainer is $CONTAINER_ID_MASTER"
docker exec -it $CONTAINER_ID_MASTER spark-submit --master spark://localhost:7077 --class bdfi.lab.recommenderproject.RunRecommender /ScalaRecommender/target/scala-2.11/recommender_2.11-2.0.0.jar

#docker exec -ti scalaRecommender_master.1 spark-submit --master spark://master:7077 /ScalaRecommender/target/scala-2.11/recommender_2.11-2.0.0.jar