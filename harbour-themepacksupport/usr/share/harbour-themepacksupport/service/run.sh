#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport
iconpack=$(<$main/icon-current)
source $main/config.shlib

$main/icon-restore.sh
$main/icon-backup.sh
$main/icon-run.sh $iconpack
if [[ "$(config_get iconoverlay)" == "1" ]]; then
	$main/icon-overlay.sh $iconpack
fi

touch /usr/share/applications/*.desktop
