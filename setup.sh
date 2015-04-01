#!/bin/bash

. $TCONF/lib/homemaker.sh || exit 1

INPUT=$HOME/tconf
OUTPUT=$HOME
CONFIG=setup.sh

hm_init

hml i3 .i3
hml shell/bashrc .bashrc
hml shell/zshrc .zshrc

hmgl .Xresources "!!" $INPUT/Xresources/*

# Import local configs.
[ -f $INPUT/local/$CONFIG ] && . $INPUT/local/$CONFIG
[ -f $INPUT/priv/$CONFIG ] && . $INPUT/priv/$CONFIG

:
