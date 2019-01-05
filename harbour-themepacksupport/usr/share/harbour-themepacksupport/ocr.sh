#!/bin/bash

main=/usr/share/harbour-themepacksupport

echo "Starting one-click restore"

$main/restore_dpr.sh
$main/restore_iz.sh
$main/restore_adpi.sh
$main/icon-restore.sh
$main/graphic-restore.sh
$main/font-restore.sh
$main/sound-restore.sh
