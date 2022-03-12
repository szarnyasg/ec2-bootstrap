#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd /data

git clone https://github.com/ldbc/ldbc_snb_interactive_impls

cd ldbc_snb_interactive_impls
scripts/build.sh
cd ..
