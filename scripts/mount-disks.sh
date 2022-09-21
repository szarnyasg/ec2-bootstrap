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
sudo mount ${NVME_DEVICE} /data

# try mounting additional disks
for INDEX in 2 3 4; do
    export NVME_DEVICE=/dev/nvme${INDEX}n1
    # only attempt creating disk if block device ${NVME_DEVICE} exists
    if [ -b ${NVME_DEVICE} ]; then
        sudo mount ${NVME_DEVICE} /data${INDEX}
    fi
done
