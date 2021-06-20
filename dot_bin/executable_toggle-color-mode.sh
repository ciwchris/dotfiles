#!/bin/sh

[[ -f $HOME/.bin/color-mode/current-color-mode ]] && SOLARIZED_THEME=$(<$HOME/.bin/color-mode/current-color-mode)

if [ -z "$SOLARIZED_THEME" ]; then
	[[ -f $HOME/.Xdark ]] && xrdb -merge $HOME/.Xdark
	SOLARIZED_THEME="dark"
elif [ "$SOLARIZED_THEME" != "light" ]; then
	[[ -f $HOME/.Xlight ]] && xrdb -merge $HOME/.Xlight
	SOLARIZED_THEME="light"
elif [ "$SOLARIZED_THEME" != "dark" ]; then
	[[ -f $HOME/.Xdark ]] && xrdb -merge $HOME/.Xdark
	SOLARIZED_THEME="dark"
fi
echo $SOLARIZED_THEME > $HOME/.bin/color-mode/current-color-mode
