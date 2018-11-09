#Choose an Ubuntu with Openjdk8 as base:
FROM openjdk:8u181

#Create the working directory
WORKDIR /ScalaRecommender

#Copy our application
COPY . /ScalaRecommender


#Install Scala

ENV SCALA_VERSION 2.11.8

RUN curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && echo >> /root/.bashrc && echo "export PATH=~/$SCALA_VERSION/bin:$PATH" >> /root/.bashrc

#Install SBT

RUN echo "deb https://dl.bintray.com/sbt/debian /" |  tee -a /etc/apt/sources.list.d/sbt.list ;apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823;apt-get update;apt-get install apt-transport-https; apt-get update;apt-get install sbt;sbt sbtVersion

#Package our application
RUN sbt package


