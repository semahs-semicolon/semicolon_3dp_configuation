#!/bin/bash

for file in ./printers/*; do
  echo "Starting Klipper and Moonraker for $file"
  docker-compose -f $file/docker-compose.yml up -d
done
