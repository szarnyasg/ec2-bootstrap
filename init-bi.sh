#!/bin/bash

set -eu

cd /data

# BI repository
git clone https://github.com/ldbc/ldbc_snb_bi

cd ldbc_snb_bi
scripts/install-dependencies.sh
cd ..
