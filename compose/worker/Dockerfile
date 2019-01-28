#Choose an Ubuntu with Openjdk8 as base:
FROM openjdk:8u181

# Install Spark 2.1.3
RUN curl http://apache.rediris.es/spark/spark-2.1.3/spark-2.1.3-bin-hadoop2.7.tgz | tar xvz --directory /root/ && echo "export PATH=~/spark-2.1.3-bin-hadoop2.7/bin:$PATH" >> /root/.bashrc

ENV PATH "$PATH:/root/spark-2.1.3-bin-hadoop2.7/bin"

#  The following 2 instructions are not needed with hdfs
# Create a path for the dataset
#RUN mkdir /root/recoDataset
# Copy the dataset to the created path
#COPY ./datasetFiles /root/recoDataset

# (Optional) Download the dataset
#RUN curl https://storage.googleapis.com/aas-data-sets/profiledata_06-May-2005.tar.gz --output "profiledata_06-May-2005.tar.gz" && tar -xvzf profiledata_06-May-2005.tar.gz;head -n 10000 ./profiledata_06-May-2005/user_artist_data.txt > ./profiledata_06-May-2005/user_artist_data_10000.txt;mv ./profiledata_06-May-2005/* /root/recoDataset