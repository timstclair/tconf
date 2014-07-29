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

if [ ! $HOSTNAME ]; then
  echo "Hostname not set."
  exit -1
fi

echo "Coping device config..."
cp -rv $TCONF/devices/$HOSTNAME/. ~/
cp -rv $TCONF/i3/. ~/.i3

echo "Generating modular configs..."
$TCONF/scripts/gen-config.sh --overwrite

# Check that symlink is up-to-date
if [ "$TCONF" != "$HOME/.tconf" ]; then
  ln -snf $TCONF $HOME/.tconf
fi