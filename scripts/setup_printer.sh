#!/bin/bash

find ../printers -type f -exec {} \; | while read -r file; do
  echo "Starting Klipper and Moonraker for $file"
  docker-compose -f $file/docker-compose.yml up -d
done
