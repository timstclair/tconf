#!/bin/bash

function print_color() {
  COLOR=$1
  TEXT=${@:2}

  RESET='\033[m'
  case ${COLOR,,} in
    cyan) FMT='\033[0;36m';;
    # TODO: Add colors
    *) FMT=RESET;;
  esac
  echo -e $FMT$TEXT$RESET
}

function DEBUG() {
  CMD=$@
  if [[ "$__DEBUG__"  == *r* ]]; then
    print_color CYAN $CMD
  fi
  if [[ "$__DEBUG__"  != ro ]]; then
    $CMD
  fi
}
