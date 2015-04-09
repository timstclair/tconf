#!/bin/bash

. $TCONF/lib/homemaker.sh || exit 1

INPUT=$HOME/tconf
OUTPUT=$HOME
CONFIG=setup.sh

hm_init

# i3 configuration
hmgl .i3/config "#" i3/config local/i3/config priv/i3/config

# shell configuration
hml shell/bashrc .bashrc
hml shell/zshrc .zshrc

hmgl .Xresources "!!" $INPUT/Xresources/*

# Import local configs.
[ -f $INPUT/local/$CONFIG ] && . $INPUT/local/$CONFIG
[ -f $INPUT/priv/$CONFIG ] && . $INPUT/priv/$CONFIG

:
