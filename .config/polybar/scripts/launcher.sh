#!/usr/bin/env bash

DIR="$HOME/.config/polybar/themes"

launcher() {
	rofi -no-config -no-lazy-grab -show drun -modi drun -theme "$DIR"/launcher.rasi
}

launcher
