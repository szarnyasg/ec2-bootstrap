#!/bin/bash

set -eu

cd ../
git clone git@github.com:cwida/duckpgq-experiments.git

git clone --recurse-submodules https://github.com/cwida/duckpgq-extension.git
