#!/bin/bash
 
# clean-up containers
docker rm -f $(docker ps -aq)
 
# create a network
docker network create trio-task-network
 
# create a volume
docker volume create new-volume
 
# build images for flask + db
docker build -t trio-task-mysql:5.7 db
docker build -t trio-task-flask-app:latest flask-app
 
# run mysql container
docker run -d \
    --name mysql \
    --network trio-task-network \
    --mount type=volume,source=new-volume,target=/var/lib/mysql \
    trio-task-mysql:5.7
 
# run flask app
 
docker run -d \
    -e MYSQL_ROOT_PASSWORD=password \
    --name flask-app \
    --network trio-task-network \
    trio-task-flask-app:latest
 
# run nginx container
docker run -d \
    -p 80:80 \
    --network trio-task-network \
    --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf \
    nginx:latest
 
# Show running containers
docker ps -a