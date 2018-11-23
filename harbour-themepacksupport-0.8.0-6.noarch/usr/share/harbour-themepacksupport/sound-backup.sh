#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport
dir_jolla=/usr/share/sounds/jolla-ambient/stereo

# Copy Jolla sounds
cp $dir_jolla/* $main/backup/sound/

exit 0
