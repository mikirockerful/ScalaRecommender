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

# Run the built application
The application requires two parameters to run:
* The directory of the host machine where the dataset is located, which will be bound to a directory in the container
* The URL of the Spark master. Note that "local" here would be inside the container, so it is not a valid parameter.
```
sudo docker run -it --mount type=bind,src=<DATASET-DIRECTORY>,dst=/root/recoDataset scalarecommender spark-submit --master <SPARK-MASTER-URL> /ScalaRecommender/target/scala-2.11/recommender_2.11-2.0.0.jar
```
