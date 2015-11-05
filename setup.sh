#!/bin/bash

. $TCONF/lib/homemaker.sh || exit 1

INPUT=$HOME/tconf
OUTPUT=$HOME
CONFIG=setup.sh

hm_init

# i3 configuration
hmgl .i3/config "#" {,local/,priv/}i3/{config,keys,win_rules}

# shell configuration
hml shell/bashrc .bashrc
hml shell/zshrc .zshrc
hml Xresources/base .Xresources

# git configuration
hml git/gitconfig .gitconfig
hml git/ignore .gitignore

# Import local configs.
[ -f $INPUT/local/$CONFIG ] && . $INPUT/local/$CONFIG
[ -f $INPUT/priv/$CONFIG ] && . $INPUT/priv/$CONFIG

: # Clear command status
