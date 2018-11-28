#!/bin/bash

# Download the dataset
curl https://storage.googleapis.com/aas-data-sets/profiledata_06-May-2005.tar.gz --output "profiledata_06-May-2005.tar.gz"
# Uncompress
tar -xvzf profiledata_06-May-2005.tar.gz
# Rename the directory
mv profiledata_06-May-2005 datasetFiles
# Take only the first 10000 records
head -n 10000 ./datasetFiles/user_artist_data.txt > ./datasetFiles/user_artist_data_10000.txt
# Copy the dataset files to Dockerfiles' context
cp -r datasetFiles ./master && cp -r datasetFiles ./worker
# Build worker and master containers with their corresponding tags (the ones they are referenced by in the compose)
docker build -t chookly/master:kubernetes ./master
docker build -t chookly/worker:kubernetes ./worker
# Launch the compose with Kompose
kompose up 