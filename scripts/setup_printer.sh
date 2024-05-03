#!/bin/bash

source ./scripts/parse_yaml.sh

eval $(parse_yaml ../config.yml "config_")

docker network create -d macvlan \
  --subnet=$config_outerNetwork_subnet \
  --ip-range=$config_outerNetwork_ipRange \
  --gateway=$config_outerNetwork_gateway \
  -o parent=$config_outerNetwork_parent \
  3dp_outerNetwork

for file in ../printers/*; do
  echo "Stopping Loaded Klipper and Moonraker for $file"
  docker-compose -f $file/docker-compose.yml down -d
done

for file in ../printers/*; do
  echo "Starting Klipper and Moonraker for $file"
  docker-compose -f $file/docker-compose.yml up -d
done
