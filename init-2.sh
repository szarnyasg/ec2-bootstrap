#!/bin/bash

# mount NVMe disk
export NVME_DEVICE=/dev/nvme1n1
sudo mkfs -t ext4 ${NVME_DEVICE}
sudo mkdir /mnt
sudo mount ${NVME_DEVICE} /mnt
sudo chown -R ${USER}:${USER} /mnt
sudo systemctl stop docker
sudo mkdir -p /etc/docker
echo '{ "data-root": "/mnt/docker" }' | sudo tee /etc/docker/daemon.json > /dev/null
sudo systemctl start docker
docker run hello-world
