#!/bin/sh
#
# Grab the colors from .Xresources and echo a complete and valid colors.rasi
# file.

. xvars

printf "* {\n"
printf "    xbg: %s;\n" $XBG
printf "    xfg: %s;\n" $XFG
printf "    x0: %s;\n" $X0
printf "    x1: %s;\n" $X1
printf "    x2: %s;\n" $X2
printf "    x3: %s;\n" $X3
printf "    x4: %s;\n" $X4
printf "    x5: %s;\n" $X5
printf "    x6: %s;\n" $X6
printf "    x7: %s;\n" $X7
printf "    x8: %s;\n" $X8
printf "    x9: %s;\n" $X9
printf "    x10: %s;\n" $X10
printf "    x11: %s;\n" $X11
printf "    x12: %s;\n" $X12
printf "    x13: %s;\n" $X13
printf "    x14: %s;\n" $X14
printf "    x15: %s;\n" $X15
printf "}\n"