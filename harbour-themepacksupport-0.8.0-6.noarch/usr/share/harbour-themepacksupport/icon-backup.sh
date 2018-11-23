#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport
dir_jolla=/usr/share/themes/sailfish-default/meegotouch
dir_native=/usr/share/icons/hicolor
dir_apk=/var/lib/apkd

# Disable service
if [[ "$(sed -n 2p $main/themepacksupport.cfg)" =~ "1" ]]; then
	systemctl disable harbour-themepacksupport.timer
	systemctl stop harbour-themepacksupport.timer
	systemctl disable harbour-themepacksupport.service
	systemctl stop harbour-themepacksupport.service
fi

# Jolla icons
jollaCap=( "z2.0" "z1.75" "z1.5-large" "z1.5" "z1.25" "z1.0" )

for ((i=0;i<${#jollaCap[@]};++i)); do
	# Perform copy of existing icons
	rsync -a --ignore-existing $dir_jolla/${jollaCap[i]}/icons/*.png $main/backup/jolla/${jollaCap[i]}/icons/
done

# Native icons
nativeCap=( "256x256" "128x128" "108x108" "86x86" )

for ((i=0;i<${#nativeCap[@]};++i)); do
	# Perform copy of existing icons
	rsync -a --ignore-existing $dir_native/${nativeCap[i]}/apps/*.png $main/backup/native/${nativeCap[i]}/apps/
done

# If Android support is installed
if [ -d "$dir_apk" ]; then
	rsync -a --ignore-existing $dir_apk/ $main/backup/apk/
fi

# If DynCal is installed 
if [ -d "/usr/share/harbour-dyncal" ]; then
	rsync -a --ignore-existing /usr/share/harbour-dyncal/icons/*.* $main/backup/dyncal/
fi

# If DynClock is installed 
if [ -d "/usr/share/harbour-dynclock" ]; then
	rsync -a --ignore-existing /usr/share/harbour-dynclock/*.png $main/backup/dynclock/
fi

exit 0
