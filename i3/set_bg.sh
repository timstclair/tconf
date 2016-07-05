#!/bin/bash

if hash feh 2>/dev/null && [ -n "$BG_IMAGE" ]; then
  feh --bg-fill "$BG_IMAGE"
elif hash xsetroot 2>/dev/null && [ -n "$BG_COLOR" ]; then
  xsetroot -solid "$BG_COLOR"
fi
