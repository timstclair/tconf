#!/bin/bash

### Eample config:
#
# . homemaker.sh
#
# DEVICE=desktop
# INPUT=$HOME/tconf
# OUTPUT=$HOME
# GEN_OUT=$INPUT/.gen_files
#
# hm_init
#
# hml shell/bashrc .bashrc
# hml .i3/config i3/config
#
# hmgl .Xresources ! Xresources/*

# Default values for script parameters.
DEVICE= # No default, must be set.
INPUT=$HOME/tconf
OUTPUT=$HOME
GEN_OUT=$INPUT/.gen_files
HM_ERROR_MODE=WARNING

hm_init() {
  if [ $INPUT/local ]; then
    return
  fi

  if [ -z $DEVICE ]; then
    hm_error "\$DEVICE not set!"
    return 1
  fi

  hm_link $INPUT/devices/$DEVICE $INPUT/local
}

# Shortcuts
hml() { hm_link $@; }
hmgl() { hm_generate_link $@; }

# Check whether destination exists (and is not already the correct link)
# Create link from -> to
hm_link() {
  local SRC=$1
  local DST=$2

  # Make SRC absolute.
  if [ "${SRC:0:1}" != "/" ]; then
    SRC=$INPUT/$SRC
  fi

  # Make DST absolute.
  if [ "${DST:0:1}" != "/" ]; then
    DST=$OUTPUT/$DST
  fi

  if [ -e "$DST" ]; then
    if [ ! -h "$DST" ]; then
      hm_error "$DST exists!"
      return 1
    fi
    if [ $(readlink "$DST") != "$SRC" ]; then
      hm_error "$DST points to \"$(readlink "$DST")\"; expected \"$SRC\""
      return 1
    fi
    # Symlink is already set up.
    return 0
  fi

  ln -s "$SRC" "$DST"
}

# Concatenate srcs into a file in $GEN_OUT
# Check source modification times to determine whether it's necessary.
hm_generate_link() {
  local DST=$1
  local COMMENT=$2
  local SRCS=${@:3}

  if [ ! -d $GEN_OUT ]; then
    if [ -e $GEN_OUT ]; then
      return hm_error"Invalid generated output directory: $GEN_OUT"
    fi

    mkdir $GEN_OUT
  fi

  local REL_DST=${DST//$HOME\/}   # Make relative to home if necessary.
  local GEN_DST="$GEN_OUT/${DST//\//.}"

  if ! hm_has_changes $GEN_DST; then
    # No changes, nothing to do.
    hm_link $GEN_DST $DST || return 1
  fi

  # Filter SRCS
  local SOURCES=
  for SRC in $SRCS; do
    # Make SRC absolute.
    if [ "${SRC:0:1}" != "/" ]; then
      SRC=$INPUT/$SRC
    fi

    if [ -e $SRC ] && [[ ! $SOURCES =~ $SRC ]]; then
      SOURCES="$SOURCES $SRC"
    fi
  done

  hm_generate $GEN_DST $COMMENT $SOURCES
  hm_link $GEN_DST $DST
}

# Generate the new file at the DST from the SRCS,
# with COMMENT delimited headers (unless COMMENT == "")
hm_generate() {
  local DST=$1
  local COMMENT=$2
  local SRCS=${@:3}

  # Sanity check on comment designator length:
  if [[ ! "$COMMENT" =~ ^[^a-zA-Z0-9]{0,2}$ ]]; then
    hm_error "Unexpect comment: $COMMENT ($DST)"
    COMMENT=""
  fi

  # Clear file
  > $DST

  hm_file_header "$COMMENT" $SRCS >> $DST

  for SRC in $SRCS; do
    hm_sect_header "$COMMENT" $SRC >> $DST
    cat "$SRC" >> $DST
  done
}

# Prints a file header using COMMENT and listing SRCS
hm_file_header() {
  local COMMENT=$1
  local SRCS=${@:2}

  if [[ "$COMMENT" == "" ]]; then
    return;
  fi

  echo "$COMMENT AUTOMATICALLY GENERATED FILE - DO NOT EDIT"
  echo "$COMMENT Sources:"
  for SRC in $SRCS; do
    echo "$COMMENT   $SRC"
  done
}

# Prints a section header using COMMENT and labeled with SRC
hm_sect_header() {
  local COMMENT=$1
  local SRC=$2

  if [[ "$COMMENT" == "" ]]; then
    return;
  fi

  echo -e "\n"
  echo "$COMMENT FROM $SRC"
  # Repeate comment to a max length of 80 characters.
  printf "$COMMENT%.0s" {1..100} | head -c 80 ; echo
}

# Check whether any of the SRCS have been modified since DST was created.
hm_has_changes() {
  local DST=$1
  local SRCS=${@:2}

  if [ ! -f $DST ]; then
    return 0
  fi

  local CREATE_TIME=$(date +%s -r $DST)
  for SRC in $SRCS; do
    local MOD_TIME=$(date +%s -r $SRC)
    if (( $MOD_TIME > $CREATE_TIME )); then
      return 0
    fi
  done

  return 1
}

# Handle an error, dependeing on the error mode.
hm_error() {
  local MSG=$1

  case $HM_ERROR_MODE in
    # SILENT) # Do nothing
    WARNING)
      >&2 echo $MSG
      return 1
      ;;
    FAIL)
      >&2 echo $MSG
      exit 1
      ;;
  esac
}
