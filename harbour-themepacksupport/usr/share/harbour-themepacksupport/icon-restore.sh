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
	rsync -a --existing --ignore-times $main/backup/jolla/${jollaCap[i]}/icons/ $dir_jolla/${jollaCap[i]}/icons/
	rm -r $main/backup/jolla/${jollaCap[i]}/icons/*
done

# Native icons
nativeCap=( "256x256" "128x128" "108x108" "86x86" )

for ((i=0;i<${#nativeCap[@]};++i)); do
	# Perform copy of existing icons
	rsync -a --existing --ignore-times $main/backup/native/${nativeCap[i]}/apps/ $dir_native/${nativeCap[i]}/apps/
	rm -r $main/backup/native/${nativeCap[i]}/apps/*
done

# If Android support is installed
if [ -d "$dir_apk" ]; then
	rsync -a --existing --ignore-times $main/backup/apk/ $dir_apk/
	rm -r $main/backup/apk/*
fi

# If DynCal is installed
if [ -d "/usr/share/harbour-dyncal" ]; then
	if [ "$(ls $main/backup/dyncal)" ]; then
		cp $main/backup/dyncal/* /usr/share/harbour-dyncal/icons/
		rm -r $main/backup/dyncal/*
	fi
fi

# If DynClock is installed
if [ -d "/usr/share/harbour-dynclock" ]; then
	# Restore hd config
	if [ -s "/usr/share/harbour-dynclock/dynclock.cfg" ]; then
		echo res="128" > /usr/share/harbour-dynclock/dynclock.cfg
	fi
	if [ "$(ls $main/backup/dynclock)" ]; then
		cp $main/backup/dynclock/* /usr/share/harbour-dynclock/
		rm -r $main/backup/dynclock/*
	fi
fi

# Set no icon pack
rm $main/icon-current
echo default > $main/icon-current
dconf write /desktop/lipstick/sailfishos-uithemer/activeIconPack "'default'"

exit 0
