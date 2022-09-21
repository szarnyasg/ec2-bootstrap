#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd /data

git clone https://github.com/ldbc/ldbc_snb_interactive_driver
cat << EOF >> ~/.bashrc
export LDBC_SNB_DRIVER_DIR=/data/ldbc_snb_interactive_driver
EOF
cd ldbc_snb_interactive_driver
scripts/install-dependencies-for-convert-script.sh
cd ..

git clone https://github.com/ldbc/ldbc_snb_interactive_impls

cd ldbc_snb_interactive_impls
scripts/install-dependencies.sh
scripts/build.sh
cd ..
