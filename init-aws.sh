#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export "export BUCKET_NAME=ldbc-snb-datagen-bi-2021-07" >> ~/.bashrc
export "export AWS_PROFILE=ldbc" >> ~/.bashrc
