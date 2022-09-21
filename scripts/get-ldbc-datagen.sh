#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd /data

git clone https://github.com/ldbc/ldbc_snb_datagen_spark

curl https://archive.apache.org/dist/spark/spark-3.2.2/spark-3.2.2-bin-hadoop3.2.tgz | sudo tar -xz -C /opt/

cd ldbc_snb_datagen_spark
sbt assembly
cd ..
