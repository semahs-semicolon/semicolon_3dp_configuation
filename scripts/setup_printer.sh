#!/bin/bash

source ./parse_yaml.sh

eval $(parse_yaml ../config.yaml "config_")

docker network create -d macvlan \
  --subnet=$config_outerNetwork_subnet \
  --ip-range=$config_outerNetwork_ipRange \
  --gateway=$config_outerNetwork_gateway \
  -o parent=$config_outerNetwork_parent \
  3dp_outerNetwork

for dir in ../printers/*; do
  echo "Stopping Klipper and Moonraker for $dir"
  docker-compose -f $dir/docker-compose.yml down 
done

for dir in ../printers/*; do
  echo "Starting Klipper and Moonraker for $dir"
  docker-compose -f $dir/docker-compose.yml up -d
done

