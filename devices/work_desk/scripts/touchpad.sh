#!/bin/bash

# Adjust touchpad settings
# To view setting options:
#   xinput list-props $TOUCHPAD

export TOUCHPAD="SynPS/2 Synaptics TouchPad"

# Disable edge scrolling
xinput set-prop "$TOUCHPAD" 'Synaptics Edge Scrolling' 0 0 0

# Use 2-finger scrolling
xinput set-prop "$TOUCHPAD" 'Synaptics Two-Finger Pressure' 10
xinput set-prop "$TOUCHPAD" 'Synaptics Two-Finger Width' 8
xinput set-prop "$TOUCHPAD" 'Synaptics Two-Finger Scrolling' 1 0  # 1 1 to enable horizontal

# Enable palm detection
xinput set-prop "$TOUCHPAD" 'Synaptics Palm Detection' 1
xinput set-prop "$TOUCHPAD" 'Synaptics Palm Dimensions' 10 200

# Disable tap to click
xinput set-prop "$TOUCHPAD" 'Synaptics Tap Move' 0
