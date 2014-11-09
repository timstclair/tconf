#!/bin/bash
# Update the tconf configurations.
# NOTE: TCONF should not change when running this.

# Confirm overwriting the destination files.
echo "WARNING: This will overwrite some dot files."
read -p "Are you sure? (y/n) " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  # Don't overwrite
  echo "Aborted."
  exit 0
fi
echo

function backup_copy() {
  local SRC=$1
  local DST=$2
  if [ -e $SRC ]; then
    if [ ! -e $DST ]; then
      mkdir $DST
    fi
    for F in $(ls -A $SRC); do
      [ -e $DST/$F ] && mv -v $DST/$F $DST/${F}~ # Make a backup
      cp -rv $SRC/$F $DST/$F
    done
  fi
}

echo
if [ $DEVICE_NAME ]; then
  echo "Coping device config..."
  backup_copy $TCONF/devices/$DEVICE_NAME ~
else
  echo '$DEVICE_NAME not set'
fi

# Copy directory configs
backup_copy $TCONF/i3/. ~/.i3

echo
echo "Generating modular configs..."
$TCONF/scripts/gen-config.sh --overwrite

# Check that symlink is up-to-date
if [ "$TCONF" != "$HOME/.tconf" ]; then
  ln -snf $TCONF $HOME/.tconf
fi
