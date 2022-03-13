#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "export BUCKET_NAME=ldbc-snb-datagen-bi-2021-07" >> ~/.bashrc
echo "export AWS_PROFILE=ldbc" >> ~/.bashrc
