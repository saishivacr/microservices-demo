#!/bin/bash

services = ('adservice','cartservice','checkoutservice','currencyservice','emailservice','frontend','loadgenerator','paymentservice','productcatalogservice','recommendationservice','shippingservice')


for service in "${services[@]}"
do
    echo "Building $service dockerfile"
    cd src/$service
    sudo docker build -t public.ecr.aws/y3f2n1o2/$service .
    sudo docker push public.ecr.aws/y3f2n1o2/$service
    echo "Built and pushed $service"
done