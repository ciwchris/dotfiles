#!/bin/sh

# Also exists in .xprofile

# Turn off bell
xset b off

# Make caps as control and escape at the same time. Based on super-caps by cmatheson.
xmodmap -e "clear Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"
xmodmap -e "add Lock = Caps_Lock"
xmodmap -e "keycode 999 = Escape"

# # Map the Menu key to the PrtSc key
xmodmap -e "keysym Print = Menu" 

# # Make the newly mapped Caps Lock key also be used as an Escape key.
xcape -e "Control_L=Escape"

# map mute and unmute keys
# Not needed with X1 Carbon
# xbindkeys &
