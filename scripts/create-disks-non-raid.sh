#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# mount first NVMe disk
if [ -b /dev/xvdb ]; then
    export NVME_DEVICE=/dev/xvdb
elif [ -b /dev/nvme1n1 ]; then
    export NVME_DEVICE=/dev/nvme1n1
elif [ -b /dev/nvme0n1 ]; then
    export NVME_DEVICE=/dev/nvme0n1
fi
sudo mkfs -t ext4 ${NVME_DEVICE}
sudo mkdir /data/
sudo mount ${NVME_DEVICE} /data
sudo chown -R ${USER}:${USER} /data

# move Docker's root to disk
sudo systemctl stop docker
sudo mkdir -p /etc/docker/
echo '{ "data-root": "/data/docker" }' | sudo tee /etc/docker/daemon.json > /dev/null
sudo systemctl start docker

# try creating additional disks
for INDEX in 2 3 4; do
    export NVME_DEVICE=/dev/nvme${INDEX}n1
    # only attempt creating disk if block device ${NVME_DEVICE} exists
    if [ -b ${NVME_DEVICE} ]; then
        sudo mkfs -t ext4 ${NVME_DEVICE}
        sudo mkdir /data${INDEX}/
        sudo mount ${NVME_DEVICE} /data${INDEX}
        sudo chown -R ${USER}:${USER} /data${INDEX}
    fi
done
