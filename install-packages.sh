#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sudo dnf upgrade -y
sudo dnf install -y zstd mc the_silver_searcher nmon fzf unzip

./install-awscli.sh
