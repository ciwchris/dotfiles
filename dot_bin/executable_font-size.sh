#!/bin/sh

size=12 # Default font size

# Use new font size if one was passed in
if [[ "$1" =~ ^[0-9]+$ ]]; then
	size=$1
fi

# Write out the new font settings
echo "
! urxvt
URxvt*font: xft:terminus:size=$size:antialias=true" > $HOME/.Xfont

xrdb -merge $HOME/.Xfont
