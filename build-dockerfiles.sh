#!/bin/bash

root_dir=$(pwd)

services=("adservice" "cartservice" "checkoutservice" "currencyservice" "emailservice" "frontend" "loadgenerator" "paymentservice" "productcatalogservice" "recommendationservice" "shippingservice")

echo "Login to ECR service"
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 876737291315.dkr.ecr.us-east-1.amazonaws.com
##aws ecr-public get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin public.ecr.aws/y3f2n1o2
# sudo docker login -u AWS -p $(aws ecr-public get-login-password --region us-east-1) public.ecr.aws/y3f2n1o2

for service in "${services[@]}"
do
    echo "Building $service dockerfile"
    if [ "$service" != "cartservice" ]; then 
        cd src/$service
    else
        cd src/$service/src
    fi
    sudo docker build -t $service .
    
    # Tag and push docker image to ECR
    sudo docker tag $service:latest 876737291315.dkr.ecr.us-east-1.amazonaws.com/$service:latest
    sudo docker push 876737291315.dkr.ecr.us-east-1.amazonaws.com/$service:latest
    
    cd $root_dir
    echo "Built and pushed $service"
done
