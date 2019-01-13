#!/bin/bash

main=/usr/share/harbour-themepacksupport

echo "Starting one-click restore"

$main/disable-autoupdate.sh
dconf write /desktop/lipstick/sailfishos-uithemer/autoUpdate 0

$main/icon-restore.sh
$main/graphic-restore.sh
$main/font-restore.sh
$main/sound-restore.sh
dconf write /desktop/lipstick/sailfishos-uithemer/activeIconPack "'none'"
dconf write /desktop/lipstick/sailfishos-uithemer/activeFontPack "'none'"

$main/restore_dpr.sh
$main/restore_adpi.sh
$main/restore_iz.sh
$main/disable-dpi.sh
dconf write /desktop/lipstick/sailfishos-uithemer/densityEnabled false
