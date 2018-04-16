#!/bin/sh

# Package cleanup
apt-get update
apt-get -y --allow-unauthenticated upgrade
apt-get clean
rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
