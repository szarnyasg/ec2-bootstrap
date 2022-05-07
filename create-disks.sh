#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

NUM_DISKS=$(lsblk | grep ^nvme[^0] | wc -l)
sudo mdadm --create --verbose /dev/md0 --level=0 --name=MY_RAID --raid-devices=${NUM_DISKS} $(seq -f "/dev/nvme%gn1" 1 ${NUM_DISKS})
sudo mkfs.ext4 -L MY_RAID /dev/md0
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm.conf
sudo dracut -H -f /boot/initramfs-$(uname -r).img $(uname -r)
sudo mkdir -p /data
sudo mount LABEL=MY_RAID /data
sudo bash -c 'echo "LABEL=MY_RAID       /data   ext4    defaults,nofail        0       2" >> /etc/fstab'
sudo mount -a
sudo chown -R ${USER}:${USER} /data

# move Docker's root to disk
sudo systemctl stop docker
sudo mkdir -p /etc/docker/
echo '{ "data-root": "/data/docker" }' | sudo tee /etc/docker/daemon.json > /dev/null
sudo systemctl start docker
