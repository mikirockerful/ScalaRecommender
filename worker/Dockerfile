#Choose an Ubuntu with Openjdk8 as base:
FROM openjdk:8u181

# Install Spark 2.1.3
RUN curl http://apache.rediris.es/spark/spark-2.1.3/spark-2.1.3-bin-hadoop2.7.tgz | tar xvz --directory /root/ && echo "export PATH=~/spark-2.1.3-bin-hadoop2.7/bin:$PATH" >> /root/.bashrc

ENV PATH "$PATH:/root/spark-2.1.3-bin-hadoop2.7/bin"