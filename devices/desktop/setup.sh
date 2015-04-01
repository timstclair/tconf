#!/bin/bash

. $TCONF/lib/homemaker.sh || exit 1

INPUT=$TCONF/local

hml shell/bash_profile .bash_profile
hml etc/xinitrc .xinitrc
hml etc/yaourtrc .yaourtrc
