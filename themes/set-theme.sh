#!/bin/bash

THEME="${1:-material}"

cd $TCONF/themes
ln -sfn $THEME current-theme

if dircolors &> /dev/null; then
  DIRCOLORS=$TCONF/themes/current-theme/dircolors
  (test -r $DIRCOLORS && eval "$(dircolors -b $DIRCOLORS)" || eval "$(dircolors -b)")
fi

if [[ -f $TCONF/themes/current-theme/Xresources ]]; then
  xrdb -merge $TCONF/themes/current-theme/Xresources
fi
