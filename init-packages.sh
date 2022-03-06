#!/bin/bash

set -eu

sudo dnf upgrade -y
sudo dnf install -y zstd mc the_silver_searcher nmon fzf
