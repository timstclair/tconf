# Xsession configuration

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient"
export TERMINAL="urxvtcd"
export DESKTOP_SESSION=gnome

setxkbmap dvorak -option ctrl:nocaps

xrandr --output DP-0 --primary
xrandr --output DVI-I-1 --rotate left --right-of DP-0

xrdb -merge ~/.Xresources

xsetroot -solid "#101010" &

# Start xterm daemon
urxvtd -q -o -f &

exec i3
