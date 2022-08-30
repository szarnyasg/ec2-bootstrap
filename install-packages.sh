#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sudo rm -f /etc/yum.repos.d/bintray-rpm.repo
curl -L https://www.scala-sbt.org/sbt-rpm.repo > sbt-rpm.repo
sudo mv sbt-rpm.repo /etc/yum.repos.d/

sudo yum upgrade -y
sudo yum install -y sbt mc the_silver_searcher nmon bmon fzf sysstat tree nano m4 make cmake automake gcc gcc-c++ kernel-devel zip bc exa bat tldr python3-devel ninja-build

sudo service sysstat restart

curl -s "https://get.sdkman.io" | bash
source ~/.sdkman/bin/sdkman-init.sh
sdk install java 11.0.16-tem

