#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd /data

git clone https://github.com/ldbc/ldbc_snb_datagen_spark

curl https://downloads.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz | sudo tar -xz -C /opt/

cat << EOF >> ~/.bashrc
export SPARK_HOME=/opt/spark-3.1.2-bin-hadoop3.2
export PATH="$SPARK_HOME/bin":"$PATH"
export PLATFORM_VERSION=2.12_spark3.1
export DATAGEN_VERSION=0.5.0-SNAPSHOT
export LDBC_SNB_DATAGEN_DIR=/ldbc/ldbc_snb_datagen_spark
EOF

cd ldbc_snb_datagen_spark
tools/build.sh
cd ..
