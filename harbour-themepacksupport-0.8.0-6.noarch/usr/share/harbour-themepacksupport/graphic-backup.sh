#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport
dir_jolla=/usr/share/themes/sailfish-default/meegotouch/icons

# List graphic icons
cp $dir_jolla/* $main/backup/graphic

exit 0
