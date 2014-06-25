#!/bin/bash
# Toggle between the us and dvorak X keyboard maps.

if expr match "$(setxkbmap -query | grep layout)" 'layout: *dvorak' > /dev/null; then
  setxkbmap us
else
  setxkbmap dvorak
fi
