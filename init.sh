#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cat config-files/.gitconfig >> ~/.gitconfig
cat config-files/.tmux.conf >> ~/.tmux.conf
mkdir -p ~/.config/htop/
cat config-files/htoprc >> ~/.config/htop/htoprc


tmux new-session -s ldbc -n etc -d 'cd ~/ec2-bootstrap/ && ./install-packages.sh; bash -i'
tmux split-window -h 'htop'
tmux select-pane -L
tmux split-window -v 'cd ~/ec2-bootstrap/ && ./get-aws.sh && bash -i'
tmux select-pane -D
tmux split-window -v 'cd /data; bash -i'

tmux -2 attach-session -t ldbc
