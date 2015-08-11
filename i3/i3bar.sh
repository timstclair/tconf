#!/bin/bash
# Wrapper around i3status to add custom output
# TODO: unused

# Order to print commands in
ORDER="kbd_layout i3status"

# Command to run i3status with
I3STATUS_CMD="i3status -c ~/.i3/i3status.conf"

# Output delimiter
DELIM=" | "


function kbd_layout() {
  if expr match "$(setxkbmap -query | grep layout)" 'layout: *dvorak' > /dev/null; then
    echo "DV"
  else
    echo "US"
  fi
}

# Generate the output
$I3STATUS_CMD | while :
do
  read I3STATUS || exit 1
  OUTPUT=""
  for CMD in $ORDER; do
    if [ "$CMD" = "i3status" ]; then
      OUTPUT="${OUTPUT}${I3STATUS}"
    else
      OUTPUT="${OUTPUT}$($CMD)"
    fi
    OUTPUT="${OUTPUT}${DELIM}"
  done

  # Strip trailing delimiter
  echo ${OUTPUT:0:-${#DELIM}} || exit 1
done

echo "DONE"
