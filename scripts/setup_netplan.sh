#!/bin/bash

rm -rf /etc/netplan/01-school-net.yaml
mv ../netplan/01-school-net.yaml /etc/netplan/01-school-net.yaml
netplan apply