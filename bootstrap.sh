#!/bin/bash

set -eu
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# prompt
cat << EOF >> ~/.bashrc
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
EOF

# gitconfig
cat << EOF >> ~/.gitconfig
[core]
	editor = vim
	quotepath = false
[push]
	default = current
[color]
	ui = auto
[alias]
	ci = commit
	st = status
	di = diff
	ds = diff --staged
	d = diff --word-diff
	oneline = log --pretty=oneline
	br = branch
	la = log --pretty="format:%ad %h (%an): %s" --date=short
	co = checkout
	cp = cherry-pick
	getremote = config --get remote.origin.url
	work = log --pretty=format:\"%h%x09%an%x09%ad%x09%s\"
	hs = log --pretty='%C(yellow)%h %C(cyan)%ad %Cblue%an%C(auto)%d %Creset%s' --date=relative --date-order --graph
	root = rev-parse --show-toplevel
EOF

# packages
sudo dnf install -y tmux wget git docker htop vim maven python3-pip

# SELinux can get in the way of benchmarking, consider disabling it
echo "sudo setenforce 0" >> ~/.bashrc

# grab keys
curl -s https://github.com/szarnyasg.keys >> ~/.ssh/authorized_keys

# make Docker work
sudo gpasswd -a ${USER} docker
cat << EOF >> ~/.bashrc
	newgrp docker
	exit
EOF

# grab repository
cd ~
git clone https://github.com/szarnyasg/ec2-bootstrap
~/ec2-bootstrap/init.sh
