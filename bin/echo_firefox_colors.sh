#!/bin/sh
#
# Grab the colors from .Xresources and echo colors for use in Firefox
# customization.

. xvars

printf "    --background: %s;\n" $XBG
printf "    --color0: %s;\n" $X0
printf "    --color1: %s;\n" $X1
printf "    --color2: %s;\n" $X2
printf "    --color3: %s;\n" $X3
printf "    --color4: %s;\n" $X4
printf "    --color5: %s;\n" $X5
printf "    --color6: %s;\n" $X6
printf "    --color7: %s;\n" $X7
printf "    --color8: %s;\n" $X8
printf "    --color9: %s;\n" $X9
printf "    --color10: %s;\n" $X10
printf "    --color11: %s;\n" $X11
printf "    --color12: %s;\n" $X12
printf "    --color13: %s;\n" $X13
printf "    --color14: %s;\n" $X14
printf "    --color15: %s;\n" $X15