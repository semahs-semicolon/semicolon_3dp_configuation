#!/bin/bash

source ./parse_yaml.sh

eval $(parse_yaml ../config.yaml "config_")
for dir in ../printers/*; do
  echo "Stopping Klipper and Moonraker Service for $dir"
  systemctl stop klipper-$dir.service
  systemctl stop moonraker-$dir.service
done

for dir in ../printers/*; do
  echo "Stopping Klipper and Moonraker for $dir"
  docker-compose -f $dir/docker-compose.yml down 
done

for dir in ../printers/*; do
  echo "Starting Klipper and Moonraker for $dir"
  docker-compose -f $dir/docker-compose.yml up -d
done

