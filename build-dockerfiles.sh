#!/bin/bash

services=("adservice" "cartservice" "checkoutservice" "currencyservice" "emailservice" "frontend" "loadgenerator" "paymentservice" "productcatalogservice" "recommendationservice" "shippingservice")


echo "Login to ECR service"
aws ecr-public get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin public.ecr.aws/y3f2n1o2
# sudo docker login -u AWS -p $(aws ecr-public get-login-password --region us-east-1) public.ecr.aws/y3f2n1o2

for service in "${services[@]}"
do
    echo "Building $service dockerfile"
    if [$service != "cartservice"]; then
        cd src/$service
    else
        cd src/$service/src
    fi
    sudo docker build -t public.ecr.aws/y3f2n1o2/$service .
    sudo docker push public.ecr.aws/y3f2n1o2/$service
    echo "Built and pushed $service"
done