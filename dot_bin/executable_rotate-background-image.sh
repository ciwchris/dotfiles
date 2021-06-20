#!/bin/sh

backgroundImages=($(ls $HOME/.config/wallpapers/*.jpg))
randomNumber=$(( $RANDOM % ${#backgroundImages[*]} + 1 ));
feh --bg-fill ${backgroundImages[randomNumber]}
