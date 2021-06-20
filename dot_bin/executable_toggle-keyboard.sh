#!/bin/sh

[[ -f $HOME/.bin/current-keyboard-mode ]] && KEYBOARD_LAYOUT=$(<$HOME/.bin/current-keyboard-mode)

if [ -z "$KEYBOARD_LAYOUT" ]; then
    setxkbmap -layout us -variant dvorak
    KEYBOARD_LAYOUT="dvorak"
elif [ "$KEYBOARD_LAYOUT" != "dvorak" ]; then
    setxkbmap -layout us -variant dvorak
    KEYBOARD_LAYOUT="dvorak"
elif [ "$SOLARIZED_THEME" != "qwerty" ]; then
    setxkbmap -layout us
    KEYBOARD_LAYOUT="qwerty"
fi
echo $KEYBOARD_LAYOUT > $HOME/.bin/current-keyboard-mode

$HOME/.bin/set-keymapping.sh
