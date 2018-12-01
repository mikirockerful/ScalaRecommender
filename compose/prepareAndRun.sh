#!/bin/bash

#Number of workers to deploy
workersNumber=1

if [ $# -eq 1 ]; then
	if [ $1 -eq 0 ]; then
		echo "0 is not a valid number" >&2; exit 1
	else
        re='^[0-9]+$'
		if ! [[ $1 =~ $re ]] ; then
   			echo "Argument is not a valid number" >&2; exit 1
   		else 
   			workersNumber=$1
		fi
	fi
elif [ $# -gt 1 ]; then
	echo "Too many arguments" >&2; exit 1
fi

# Download the dataset
curl https://storage.googleapis.com/aas-data-sets/profiledata_06-May-2005.tar.gz --output "profiledata_06-May-2005.tar.gz"
# Uncompress
tar -xvzf profiledata_06-May-2005.tar.gz
# Rename the directory
mv profiledata_06-May-2005 datasetFiles
# Take only the first 10000 records
head -n 10000 ./datasetFiles/user_artist_data.txt > ./datasetFiles/user_artist_data_10000.txt
## The following command is not needed wit HDFS
# Copy the dataset files to Dockerfiles' context
#cp -r datasetFiles ./master && cp -r datasetFiles ./worker
# Build it
docker-compose build
# Run it in background
docker-compose up -d --scale worker=$workersNumber
# Wait 10 seconds - namenode needs some time to start running
echo "Waiting for 10 seconds..."
sleep 10
# Copy the directory with dataset files from host to cointainer
docker cp ./datasetFiles/ namenode:/
# Copy from container's local fs to HDFS
docker exec namenode hadoop fs -copyFromLocal /datasetFiles /
# Remove datasetFiles from container's local fs
#docker exec namenode rm -r /datasetFiles
# Remove the datasetFiles
rm profiledata_06-May-2005.tar.gz
rm -r datasetFiles
## These 2 commands are not needed when working with hdfs
#rm -r ./master/datasetFiles
#rm -r ./worker/datasetFiles
# Execute the recommender
docker exec -it scalarecommender_master_1 spark-submit --master spark://master:7077 /ScalaRecommender/target/scala-2.11/recommender_2.11-2.0.0.jar