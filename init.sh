#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#./mount-disk.sh

tmux new-session -s ldbc -n etc -d 'cd ~/ec2-bootstrap/ && ./init-packages.sh; bash -i'
tmux split-window -h 'htop'
tmux select-pane -L
tmux split-window -v 'cd ~/ec2-bootstrap/ && ./init-datagen.sh; bash -i'
tmux select-pane -U
tmux split-window -v 'cd ~/ec2-bootstrap/ && ./init-bi.sh; bash -i'
tmux select-pane -D
tmux split-window -v 'cd /data; bash -i'

tmux -2 attach-session -t ldbc
