#!/bin/bash

main=/usr/share/harbour-themepacksupport

echo "Starting one-click restore before system upgrade"

$main/disable-autoupdate.sh

$main/ocr.sh
