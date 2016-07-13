#!/bin/bash
# Toggle between the us and dvorak X keyboard maps.

LAYOUT=${1:-toggle}

if [[ "$LAYOUT" == "toggle" ]]; then
  CURRENT="$(setxkbmap -query | awk '/layout:/ {print $2}')"
  case "$CURRENT" in
    dvorak)
      LAYOUT=us
      ;;
    us)
      LAYOUT=dvorak
      ;;
    *)
      echo "Unknown layout: $CURRENT" >&2
      exit 1
      ;;
    esac
fi

setxkbmap "$LAYOUT" -option ctrl:nocaps
