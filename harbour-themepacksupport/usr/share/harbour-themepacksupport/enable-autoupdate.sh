#!/bin/bash

main=/usr/share/harbour-themepacksupport

systemctl enable themepacksupport-autoupdate.timer
systemctl start themepacksupport-autoupdate.timer
systemctl enable themepacksupport-autoupdate.service
systemctl start themepacksupport-autoupdate.service
sed -i "s/.*tps_service.*/tps_service='1'/" $main/themepacksupport.cfg

