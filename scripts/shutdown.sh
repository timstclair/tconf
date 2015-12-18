#!/bin/bash
#
# a simple logout script which gracefully
# closes all apps before executing
#
###

message() {
  echo "usage: leave [option]"
  echo
  echo "  options:"
  echo "        -e       logout / kill X"
  echo "        -r       reboot system"
  echo "        -s       shutdown system"
  echo
  exit 1
}

if command -v systemctl >/dev/null 2>&1 ; then
  # systemd system
  SHUTDOWN="systemctl poweroff"
  REBOOT="systemctl reboot"
else
  SHUTDOWN="poweroff"
  REBOOT="reboot"
fi

case $1 in
  -e) LABEL="Logout"  ; [ -z "$DISPLAY" ] && ACTION="logout" || ACTION="kill $(pgrep X)" ;;
  -r) LABEL="Restart" ; ACTION="$REBOOT" ;;
  -s) LABEL="Shutdown"; ACTION="$SHUTDOWN" ;;
  *)             message          ;;
esac

# no X?
if [ -z "$DISPLAY" ]; then
  echo -n "system will $LABEL in 3... "
  sleep 1 && echo -n "2... "
  sleep 1 && echo "1... "
  sleep 1 && $ACTION &

  exit 0
fi

# are you sure?
if zenity --question \
          --title=$LABEL \
          --ok-label=$LABEL \
          --text="are you sure you want to $LABEL?"; then

  # gracefully close all apps
  i3-msg '[class=".*"] kill'

  # do it
  sleep 3 && $ACTION

  exit 0
fi

# if we're still here, fail
exit 1
