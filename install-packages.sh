#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sudo yum upgrade -y
sudo yum install -y sbt mc the_silver_searcher nmon bmon fzf sysstat tree nano m4 make cmake automake gcc gcc-c++ kernel-devel zip bc exa bat tldr python3-devel

sudo service sysstat restart
