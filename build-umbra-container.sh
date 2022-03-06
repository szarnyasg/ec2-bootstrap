#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: init-umbra.sh <UMBRA_URL>"
fi

export UMBRA_URL=$1

cd /data/ldbc_snb_bi/umbra
scripts/build-container.sh
