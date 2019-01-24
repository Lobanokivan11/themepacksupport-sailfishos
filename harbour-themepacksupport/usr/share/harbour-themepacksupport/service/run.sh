#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport
iconpack=$(<$main/icon-current)

$main/icon-backup.sh
$main/icon-run.sh $iconpack

touch /usr/share/applications/*.desktop
