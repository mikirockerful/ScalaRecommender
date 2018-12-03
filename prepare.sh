# !/bin/bash

# Based on https://github.com/testdrivenio/spark-docker-swarm
### Preparation
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

# Create a couple of VMs for the swarm
docker-machine create --driver virtualbox manager
echo "[INFO] Manager created!"
docker-machine create --driver virtualbox follower1
echo "[INFO] Follower1 created!"
#docker-machine create --driver virtualbox follower2
#echo "[INFO] Follower2 created!"

# Make "manager" the swarm manager
docker-machine ssh manager "docker swarm init --advertise-addr $(docker-machine ip manager)"
#docker-machine ssh manager "docker node update --availability drain manager"
echo "[INFO] 'manager' is already the swarm manager."
echo "[INFO] Creating network..."

# Join "follower" to the swarm
TOKEN=`docker-machine ssh manager docker swarm join-token worker | grep token | awk '{ print $5 }'`
docker-machine ssh follower1 "docker swarm join --token ${TOKEN} $(docker-machine ip manager):2377"
#docker-machine ssh follower2 "docker swarm join --token ${TOKEN} $(docker-machine ip manager):2377"
echo "[INFO] 'followers are already in the swarm cluster."

# Create the network1
docker-machine ssh manager "docker network create -d overlay --attachable myNetwork"
# Configuring the shell to interact directly with the manager's one, without needing to execute "docker-machine ssh manager". These 2 commands depend on the host OS - valid for macOS and Linux
eval $(docker-machine env manager)
export EXTERNAL_IP=$(docker-machine ip follower1)


# Deploy to swarm
docker stack deploy --with-registry-auth -c docker-compose.yml scalaRecommender
#sleep 30
#echo "[INFO] Stack already deployed, waiting 30 seconds..."

# Scale the number of workers
#eval $(docker-machine env manager) 
#echo "[INFO] Scaling the number of spark workers to $workersNumber..."
#docker service scale scalaRecommender_worker=$workersNumber
