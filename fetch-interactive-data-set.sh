#!/bin/bash

set -u

cd /data

mkdir interactive_data_sets
cd interactive_data_sets

echo "SF: ${SF}"

curl -s https://repository.surfsara.nl/datasets/cwi/snb/files/substitution_parameters/substitution_parameters.tar.zst | tar -xv -I zstd &
curl -s https://repository.surfsara.nl/datasets/cwi/snb/files/social_network-csv_merge_foreign/social_network-csv_merge_foreign-sf${SF}.tar.zst | tar -xv -I zstd &
curl -s https://repository.surfsara.nl/datasets/cwi/snb/files/updatestreams/sf${SF}/social_network-sf${SF}-numpart-1.tar.zst | tar -xv -I zstd &
curl -s https://repository.surfsara.nl/datasets/cwi/snb/files/updatestreams/sf${SF}/social_network-sf${SF}-numpart-2.tar.zst | tar -xv -I zstd &
curl -s https://repository.surfsara.nl/datasets/cwi/snb/files/updatestreams/sf${SF}/social_network-sf${SF}-numpart-4.tar.zst | tar -xv -I zstd &
curl -s https://repository.surfsara.nl/datasets/cwi/snb/files/updatestreams/sf${SF}/social_network-sf${SF}-numpart-8.tar.zst | tar -xv -I zstd &
curl -s https://repository.surfsara.nl/datasets/cwi/snb/files/updatestreams/sf${SF}/social_network-sf${SF}-numpart-16.tar.zst | tar -xv -I zstd &
curl -s https://repository.surfsara.nl/datasets/cwi/snb/files/updatestreams/sf${SF}/social_network-sf${SF}-numpart-24.tar.zst | tar -xv -I zstd &
curl -s https://repository.surfsara.nl/datasets/cwi/snb/files/updatestreams/sf${SF}/social_network-sf${SF}-numpart-32.tar.zst | tar -xv -I zstd &
curl -s https://repository.surfsara.nl/datasets/cwi/snb/files/updatestreams/sf${SF}/social_network-sf${SF}-numpart-48.tar.zst | tar -xv -I zstd &
