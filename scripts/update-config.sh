#!/bin/bash

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

echo "Generating modular configs..."
$TCONF/scripts/gen-config.sh --overwrite
