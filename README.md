# ScalaRecommender
Music recommender system built for university course on Big Data infrastructure

# How to run locally
1 Package your application:
```
 sbt package
```
2 Run Spark shell:
```
 <spark-2.1.3-base>/bin/spark-shell 
```
3 Submit the job to the locally running Spark
```
<spark-2.1.3-base>/bin/spark-submit --class bdfi.lab.recommenderproject.RunRecommender --master local <project-base-directory>/target/scala-2.11/recommender_2.11-2.0.0.jar
```
