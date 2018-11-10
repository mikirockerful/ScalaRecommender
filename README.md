# ScalaRecommender
Music recommender system built for university course on Big Data infrastructure

# How to run locally
1 Change the value of "base" variable in RunRecommender.main() to point to your data location

2 Package your application:
```
 sbt package
```
3 Run Spark shell:
```
 <spark-2.1.3-base>/bin/spark-shell 
```
4 Submit the job to the locally running Spark
```
<spark-2.1.3-base>/bin/spark-submit --class bdfi.lab.recommenderproject.RunRecommender --master local <project-base-directory>/target/scala-2.11/recommender_2.11-2.0.0.jar
```

# How to run as a spark cluster

1 Run "prepareAndRun.sh" to download the dataset, build the compose with the individual containers, and submit the application to the Spark cluster.

The Spark master will be accessible through its web UI (http://localhost:8080), as well as the workers (http://localhost:8081 and http://localhost:8082).

2 To run the application more times, after the compose is up:
```
docker exec -it master_master_1 spark-submit --master spark://localhost:7077 /ScalaRecommender/target/scala-2.11/recommender_2.11-2.0.0.jar
```

