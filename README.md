# ScalaRecommender
Music recommender system built for university course on Big Data infrastructure

# Build & run locally
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

# How to run as a spark cluster using HDFS

1 Login to docker hub (to pull images from private repo)
```
docker login
```

2 Go to ./compose directory

3 Run "prepareAndRun.sh" to download the dataset, build the compose with the individual containers, load dataset files to hdfs and submit the application to the Spark cluster. It takes one optional argument to set the number of spark workers. For example, to run the compose with the master and 3 workers, run:
```
prepareAndRun.sh 3
```
The default number of workers is 1.

The Spark master will be accessible through its web UI (http://localhost:8080), as well as Spark workers and both HDFS namenode (http://localhost:50070) and datanode (http://localhost:50075).

4 To run the application more times, after the compose is up:
```
docker exec -it scalarecommender_master_1 spark-submit --master spark://master:7077 /ScalaRecommender/target/scala-2.11/recommender_2.11-2.0.0.jar
```

# Run it with Kubernetes

1 Start minikube (local) with:
```
minikube start
```

2 Run
```
kubectl create -f kubernetes.yaml
```


3 To get the status of the cluster pods, run:
```
kubectl get pods
```
The desired state should be something like this:
```
NAME                              READY   STATUS    RESTARTS   AGE
maestro-hrmz5     				  1/1     Running   0          1h
lanzador-mxqvb                    1/1     Running   4          58m
currito-44qtn                     1/1     Running   0          49m
```

We can also check the dashboard with
```
minikube dashboard
```

4 At this point, we can lanzador to launch jobs on the Spark cluster
We copy the executable to the container:
```
kubectl cp recommender_command_line.jar lanzador-mxqvb:/recommender_command_line.jar
```
Then, the dataset (requires download):
```
kubectl cp datasetFiles/ lanzador-mxqvb:datasetFiles
```
And finally, we should be able to run the job in Spark, using the spark shell from lanzador:
```
kubectl exec -it lanzador-mxqvb /bin/bash
```
From the console, we can submit the application in client mode:
```
/usr/spark-2.3.1/bin/spark-submit --class bdfi.lab.recommenderproject.RunRecommender --master spark://$MAESTRO_PORT_7077_TCP_ADDR:7077 --config spark.sql.crossJoin.enabled=true recommender_command_line.jar datasetFiles/
```

To check Spark web consoles, we need to create a proxy or port forwarding to our Kubernetes network:
```
kubectl port-forward maestro-hrmz5 8080:8080
```
Which makes the UI accessible through: http://localhost:8080

# Additional information

1 To clean ALL containers and images, just run:
```
clean.sh
```
