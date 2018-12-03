# ScalaRecommender
Music recommender system built for university course on Big Data infrastructure


# Run it with Kubernetes

1 Start minikube (local) with:
```
minikube start
```

2 Run
```
kubectl create -f kubernetes.yaml
```


3 To get the status of the cluster pods, run:
```
kubectl get pods
```
The desired state should be something like this:
```
NAME                              READY   STATUS    RESTARTS   AGE
maestro-hrmz5     				  1/1     Running   0          1h
lanzador-mxqvb                    1/1     Running   4          58m
currito-44qtn                     1/1     Running   0          49m
```

We can also check the dashboard with
```
minikube dashboard
```

4 The images already contain the data in a common path. We can use lanzador to submit the job (it has the JAR)
```
kubectl exec -it lanzador-mxqvb /bin/bash
```
From the console, we can submit the application in client mode:
```
/usr/spark-2.2.0/bin/spark-submit --class bdfi.lab.recommenderproject.RunRecommender --master spark://$MAESTRO_PORT_7077_TCP_ADDR:7077 recommender_command_line.jar datasetFiles/
```

To check Spark web consoles, we need to create a proxy or port forwarding to our Kubernetes network:
```
kubectl port-forward maestro-hrmz5 8080:8080
```
Which makes the UI accessible through: http://localhost:8080

To delete the scenario:
```
kubectl delete -f kubernetes.yaml
```