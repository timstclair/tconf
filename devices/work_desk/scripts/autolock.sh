#!/bin/bash

if ! command -v xautolock >/dev/null 2>&1; then
  i3-nagbar -m "xautolock not found"
  exit 1
fi

IDLE_TIME=5 # Idle time before locking, in minutes.
LOCK_CMD="i3lock -c 000000"

xautolock -time "$IDLE_TIME" -locker "$LOCK_CMD"
