#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

./mount-disk.sh

cat config-files/.gitconfig >> ~/.gitconfig
cat config-files/.tmux.conf >> ~/.tmux.conf
mkdir -p ~/.config/htop/
cat config-files/.htoprc >> ~/.config/htop/.htoprc

tmux new-session -s ldbc -n etc -d 'cd ~/ec2-bootstrap/ && ./init-packages.sh && ./init-aws.sh; bash -i'
tmux split-window -h 'htop'
tmux select-pane -L
tmux split-window -v 'cd ~/ec2-bootstrap/ && ./init-datagen.sh; bash -i'
tmux select-pane -U
tmux split-window -v 'cd ~/ec2-bootstrap/ && ./init-bi.sh && ./init-interactive.sh; bash -i'
tmux select-pane -D
tmux split-window -v 'cd /data; bash -i'

tmux -2 attach-session -t ldbc
