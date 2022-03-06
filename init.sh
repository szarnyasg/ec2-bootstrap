#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

./mount-disk.sh

tmux new-session -s ldbc -n etc -d '~/bootstrap-ec2 && ./init-packages.sh; bash -i'
tmux split-window -h 'htop'
tmux select-pane -L
tmux split-window -v 'cd ~/bootstrap-ec2/ && ./init-datagen.sh; bash -i'
tmux split-window -v 'cd ~/bootstrap-ec2/ && ./init-bi.sh; bash -i'

tmux -2 attach-session -t ldbc
