#!/bin/bash

spark-submit --master k8s://https://192.168.99.100:8443 --deploy-mode cluster --name minikube --class bdfi.lab.recommenderproject.RunRecommender --conf spark.executor.instances=2 --conf spark.kubernetes.container.image=chookly/bdfi:k8s local:///ScalaRecommender/project/target/scala-2.11/recommender_2.11-2.0.0.jar