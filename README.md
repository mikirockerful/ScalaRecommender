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

# Create a container
Checkout to the branch and commit with the desired Dockerfile, and move to the root directory. Then:
```
sudo docker build -t scalarecommender .
```
Where "scalarecommender" is the tag that will identify the container.

# Run a container against a local Spark master
This assumes you have a docker image called "scalarecommender" created from a Dockerfile in this repo
```
sudo docker run scalarecommender /root/spark-2.1.3-bin-hadoop2.7/bin/spark-submit /ScalaRecommender/target/scala-2.11/recommender_2.11-2.0.0.ja
```
