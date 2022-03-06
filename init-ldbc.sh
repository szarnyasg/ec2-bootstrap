#!/bin/bash

cd /data
git clone https://github.com/ldbc/ldbc_snb_datagen_spark
git clone https://github.com/ldbc/ldbc_snb_bi

curl https://downloads.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz | sudo tar -xz -C /opt/

echo 'export SPARK_HOME=/opt/spark-3.1.2-bin-hadoop3.2' >> ~/.bashrc
echo 'export PATH="$SPARK_HOME/bin":"$PATH"' >> ~/.bashrc

echo 'export PLATFORM_VERSION=2.12_spark3.1' >> ~/.bashrc
echo 'export DATAGEN_VERSION=0.5.0-SNAPSHOT' >> ~/.bashrc

echo 'export LDBC_SNB_DATAGEN_DIR=/mnt/ldbc_snb_datagen_spark' >> ~/.bashrc
