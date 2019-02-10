#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport
dir_jolla=/usr/share/themes/sailfish-default/meegotouch
dir_native=/usr/share/icons/hicolor
dir_apk=/var/lib/apkd

# Disable service
if [[ "$(sed -n 2p $main/themepacksupport.cfg)" =~ "1" ]]; then
	systemctl disable themepacksupport-autoupdate.timer
	systemctl stop themepacksupport-autoupdate.timer
	systemctl disable themepacksupport-autoupdate.service
	systemctl stop themepacksupport-autoupdate.service
fi

# Jolla icons
jollaCap=( "z2.0" "z1.75" "z1.5-large" "z1.5" "z1.25" "z1.0" )

for ((i=0;i<${#jollaCap[@]};++i)); do
	# Perform copy of existing icons
	rsync -a --existing --ignore-times $main/backup/icons/jolla/${jollaCap[i]}/icons/ $dir_jolla/${jollaCap[i]}/icons/
done

# Native icons
nativeCap=( "256x256" "172x172" "128x128" "108x108" "86x86" )

for ((i=0;i<${#nativeCap[@]};++i)); do
	# Perform copy of existing icons
	rsync -a --existing --ignore-times $main/backup/icons/native/${nativeCap[i]}/apps/ $dir_native/${nativeCap[i]}/apps/
done

# If Android support is installed
if [ -d "$dir_apk" ]; then
	rsync -a --existing --ignore-times $main/backup/icons/apk/ $dir_apk/
fi

# If DynCal is installed
if [ -d "/usr/share/harbour-dyncal" ]; then
	if [ "$(ls $main/backup/dyncal)" ]; then
		cp $main/backup/icons/dyncal/* /usr/share/harbour-dyncal/icons/
	fi
fi

# If DynClock is installed
if [ -d "/usr/share/harbour-dynclock" ]; then
	# Restore hd config
	if [ -s "/usr/share/harbour-dynclock/dynclock.cfg" ]; then
		echo res="128" > /usr/share/harbour-dynclock/dynclock.cfg
	fi
	if [ "$(ls $main/backup/dynclock)" ]; then
		cp $main/backup/icons/dynclock/* /usr/share/harbour-dynclock/
	fi
fi

rm -rf $main/backup/jolla
rm -rf $main/backup/native
rm -rf $main/backup/apk
rm -rf $main/backup/dynclock
rm -rf $main/backup/dyncal

rm -rf $main/backup/icons

# Set no icon pack
rm $main/icon-current
echo default > $main/icon-current

exit 0
