#!/bin/bash

cat << EOF >> ~/.bashrc
export SPARK_HOME=/opt/spark-3.1.2-bin-hadoop3.2
export PATH="\$SPARK_HOME/bin":"\$PATH"
export PLATFORM_VERSION=2.12_spark3.1
export DATAGEN_VERSION=0.5.0-SNAPSHOT
export LDBC_SNB_DATAGEN_DIR=/data/ldbc_snb_datagen_spark
export LDBC_SNB_DATAGEN_MAX_MEM=10G
EOF
