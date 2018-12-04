#Choose an Ubuntu with Openjdk8 as base:
FROM openjdk:8u181

#Create the working directory
WORKDIR /ScalaRecommender

#Copy our application
COPY ./app /ScalaRecommender

RUN echo "deb https://dl.bintray.com/sbt/debian /" |  tee -a /etc/apt/sources.list.d/sbt.list ;apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823;apt-get update;apt-get install apt-transport-https; apt-get update;apt-get install sbt;sbt sbtVersion

# Install Spark 2.1.3
RUN curl http://apache.rediris.es/spark/spark-2.1.3/spark-2.1.3-bin-hadoop2.7.tgz | tar xvz --directory /root/ && echo "export PATH=~/spark-2.1.3-bin-hadoop2.7/bin:$PATH" >> /root/.bashrc

# (Optional) Modify Spark's log4j properties to a less verbose mode
RUN mv ./log4j.properties ~/spark-2.1.3-bin-hadoop2.7/conf/

ENV PATH "$PATH:/root/spark-2.1.3-bin-hadoop2.7/bin"

#Package our application
RUN sbt package

# Create a path for the dataset
RUN mkdir /root/recoDataset
# Copy the dataset to the created path
COPY ./datasetFiles /root/recoDataset

#Package our application
RUN sbt package