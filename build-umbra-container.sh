#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ $# -eq 0 ]; then
    echo "Usage: init-umbra.sh <UMBRA_URL>"
fi

export UMBRA_URL=$1

cd /data/ldbc_snb_bi/umbra
scripts/build-container.sh
