#!/bin/bash

# The list of config files to generate
CONFIGS_FILE=$TCONF/CONFIGS

WARNING_HDR="AUTOMATICALLY GENERATED FILE - DO NOT EDIT"
SOURCES_HDR="Sources:"
LOCAL_SUFFIX="_local"
DIVIDER="--------------------------------------------------------------------------------"
BREAK="\n"

# Keep track of outputs
OUTPUTS=""

# Function for generating config files.
gen-config() {
  FILENAME=~/$1        # Output filename
  COMMENT=$2           # Comment designator
  SOURCES_NAMES=${@:3} # Source filenames

  # Sanity check on comment designator length:
  if [[ ! "$COMMENT" =~ ^[^a-zA-Z0-9]{1,2}$ ]]; then
    echo "Invalid comment operator: $COMMENT ($FILENAME)"
    return
  fi

  # Confirm overwriting the destination file.
  if [ -e $FILENAME ]; then
    echo "WARNING: This will overwrite $FILENAME"
    read -p "Are you sure? (y/n) " -n 1 -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      # Don't overwrite
      echo "Skipping $FILENAME"
      return
    fi
    echo
  fi

  # Find exsting sources
  SOURCES=""
  for SRC in $SOURCES_NAMES; do
    SRC=$TCONF/$SRC  # Everything relative to tconf
    if [[ -d $SRC ]]; then
      echo "Directory:  $SRC"
      for F in $(ls $SRC); do
        SRCF=$TCONF/$(basename $SRC)/$F
        SOURCES="$SOURCES $SRCF"
      done
    else
      echo "File:  $SRC"
      [ -e $SRC ] && [[ ! $SOURCES =~ $SRC ]] && \
        SOURCES="$SOURCES $SRC"
    fi
  done

  # Add the local source
  LOCAL_SRC=$FILENAME$LOCAL_SUFFIX
  [ -e $LOCAL_SRC ] && SOURCES_NAMES="$SOURCES_NAMES $LOCAL_SRC"


  # Print header
  echo -e $COMMENT $WARNING_HDR > $FILENAME  # Overwrite file!
  echo -e $COMMENT $SOURCES_HDR >> $FILENAME
  for SRC in $SOURCES; do
    echo -e $COMMENT " " $SRC >> $FILENAME
  done

  # Print body
  for SRC in $SOURCES; do
    echo -e $BREAK >> $FILENAME
    echo $COMMENT "FROM " $SRC >> $FILENAME
    echo $COMMENT $DIVIDER >> $FILENAME
    cat $SRC >> $FILENAME
  done

  OUTPUTS="$OUTPUTS $FILENAME"
}

# Load configs, ommit comments and blank lines.
CONFIGS=
COUNT=0
while read CONF; do
  if [[ ! $CONF =~ ^# ]] && [[ ! -z $CONF ]]; then
    COUNT=$((COUNT+1))
    CONFIGS[$COUNT]=$CONF
  fi
done <$CONFIGS_FILE

# Must be separate from file read for confirmation read to work.
for i in $(seq 1 $COUNT); do
  gen-config ${CONFIGS[$i]}
done

# Done! Print summary:
if [[ ! -z $OUTPUTS ]]; then
  echo "Done! Successfully wrote:"
  for OUTPUT in $OUTPUTS; do
    echo $OUTPUT
  done
else
  echo "Done! No files written."
fi
