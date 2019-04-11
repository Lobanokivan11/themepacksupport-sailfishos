#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport
iconpack=$(<$main/icon-current)

$main/icon-restore.sh
$main/icon-backup.sh
$main/icon-run.sh $iconpack
$main/icon-overlay.sh $iconpack

touch /usr/share/applications/*.desktop
