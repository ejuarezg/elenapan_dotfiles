#!/bin/sh
#
# Grab the colors from .Xresources and echo a complete and valid alacritty.yml
# file.

. xvars

printf "colors:\n"
printf "  primary:\n"
printf "    background: '%s'\n" $XBG
printf "    foreground: '%s'\n\n" $XFG
printf "  normal:\n"
printf "    black:      '%s'\n" $X0
printf "    red:        '%s'\n" $X1
printf "    green:      '%s'\n" $X2
printf "    yellow:     '%s'\n" $X3
printf "    blue:       '%s'\n" $X4
printf "    magenta:    '%s'\n" $X5
printf "    cyan:       '%s'\n" $X6
printf "    white:      '%s'\n\n" $X7
printf "  bright:\n"
printf "    black:      '%s'\n" $X8
printf "    red:        '%s'\n" $X9
printf "    green:      '%s'\n" $X10
printf "    yellow:     '%s'\n" $X11
printf "    blue:       '%s'\n" $X12
printf "    magenta:    '%s'\n" $X13
printf "    cyan:       '%s'\n" $X14
printf "    white:      '%s'\n" $X15