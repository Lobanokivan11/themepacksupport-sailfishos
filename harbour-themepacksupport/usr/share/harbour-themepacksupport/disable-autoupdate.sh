#!/bin/bash

main=/usr/share/harbour-themepacksupport

systemctl disable themepacksupport-autoupdate.timer
systemctl stop themepacksupport-autoupdate.timer
systemctl disable themepacksupport-autoupdate.service
systemctl stop themepacksupport-autoupdate.service
sed -i "s/.*tps_service.*/tps_service='0'/" $main/themepacksupport.cfg

