#!/bin/bash

set -eu

# mount NVMe disk
export NVME_DEVICE=/dev/nvme1n1
sudo mkfs -t ext4 ${NVME_DEVICE}
sudo mkdir /data
sudo mount ${NVME_DEVICE} /data
sudo chown -R ${USER}:${USER} /data
sudo systemctl stop docker
sudo mkdir -p /etc/docker
echo '{ "data-root": "/data/docker" }' | sudo tee /etc/docker/daemon.json > /dev/null
sudo systemctl start docker
docker run hello-world
