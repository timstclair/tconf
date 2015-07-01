#!/bin/bash

THEME="${1:-material}"

ln -sfn $TCONF/themes/$THEME $TCONF/themes/current-theme

if dircolors > /dev/null; then
  DIRCOLORS=$TCONF/themes/current-theme/dircolors
  (test -r $DIRCOLORS && eval "$(dircolors -b $DIRCOLORS)" || eval "$(dircolors -b)")
fi

if [[ -f $TCONF/themes/current-theme/Xresources ]]; then
  xrdb -merge $TCONF/themes/current-theme/Xresources
fi
