#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sudo yum upgrade -y
sudo yum install -y mc the_silver_searcher nmon fzf sysstat tree

sudo service sysstat restart
