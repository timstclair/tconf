#!/bin/bash

# Eample config:

. homemaker.sh || exit 1

DEVICE=desktop
INPUT=$HOME/tconf
OUTPUT=$HOME

hm_init

hml shell/bashrc .bashrc
hml .i3/config i3/config

hmgl .Xresources ! Xresources/*



hm_init() {
  hm_link $INPUT/devices/$DEVICE $INPUT/local  # FIXME: don't write to $OUTPUT
}


# Check whether destination exists (and is not already the correct link)
# Create link from -> to
hm_link() {
  DST=$1
  SRC=$2

  # TODO
}


# Concatenate srcs into a file in .tconf-gen ($GEN_OUT)
# Check source modification times to determine whether it's necessary.
hm_generate_link() {
  DST=$1
  COMMENT=$2
  SRCS=${@:3}

  GEN_OUT=~/.tconf-gen   # TODO: Read from elsewhere
  if [ ! -d $GEN_OUT ]; then
    if [ -e $GEN_OUT ]; then
      tfail "Invalid generated output directory: $GEN_OUT"
      return
    fi

    makedir $GEN_OUT
  fi

  REL_DST=${DST//$HOME\/}   # Make relative to home if necessary.
  GEN_DST="$GEN_OUT/${DST//\//.}"

  if ! has_changes $GEN_DST; then
    # No changes, nothing to do.
    tl $GEN_DST $DST
  fi

  # TODO: generate file
}

# Check whether any of the SRCS have been modified since DST was created.
hm_has_changes() {
  DST=$1
  SRCS=${@:2}

  CREATE_TIME=$(date +%s -r $DST)
  for SRC in $SRCS; do
    MOD_TIME=$(date +%s -r $SRC)
    if (( $MOD_TIME > $CREATE_TIME )); then
      return 0
    fi
  done

  return 1
}

# Handle an error, dependeing on the error mode.
hm_error() {
  MSG=$1

  case $HM_ERROR_MODE in
    SILENT)
      # Do nothing
      ;;
    WARNING)
      >&2 echo $MSG
      ;;
    FAIL)
      >&2 echo $MSG
      exit 1
      ;;
  esac
}

# Unset functions & bindings used during homemaker setup.
hm_unset() {
  # e.g.
  unset -f hm_fail
  unset $HM_ERROR_MODE
  # etc.

  # TODO
}
