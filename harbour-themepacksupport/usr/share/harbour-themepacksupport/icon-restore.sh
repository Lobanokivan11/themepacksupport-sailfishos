#!/bin/bash
#
#    Theme pack support for Sailfish OS - Enables theme pack support in Sailfish OS.
#    Copyright (C) 2015-2016  fravaccaro <fravaccaro90@gmail.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

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
	for file in $dir_jolla/${jollaCap[i]}/icons/*.png; do
		if test -e "$main/backup/jolla/${jollaCap[i]}/icons/$(basename ${file})"
			then cp "$main/backup/jolla/${jollaCap[i]}/icons/$(basename ${file})" "${file}"
		fi
	done
done

# Native icons
nativeCap=( "256x256" "128x128" "108x108" "86x86" )

for ((i=0;i<${#nativeCap[@]};++i)); do
	# Perform copy of existing icons
	for file in $dir_native/${nativeCap[i]}/apps/*.png; do
		if test -e "$main/backup/native/${nativeCap[i]}/apps/$(basename ${file})"
			then cp "$main/backup/native/${nativeCap[i]}/apps/$(basename ${file})" "${file}"
		fi
	done
done

# If Android support is installed
if [ -d "$dir_apk" ]; then
	for file in $dir_apk/*.png; do
		if test -e "$main/backup/apk/$(basename ${file})"
			then cp "$main/backup/apk/$(basename ${file})" "${file}"
		fi
	done
fi

# If DynCal is installed
if [ -d "/usr/share/harbour-dyncal" ]; then
	if [ "$(ls $main/backup/dyncal)" ]; then
		cp $main/backup/dyncal/*.* /usr/share/harbour-dyncal/icons/
	fi
fi

# If DynClock is installed
if [ -d "/usr/share/harbour-dynclock" ]; then
	# Restore hd config
	if [ -s "/usr/share/harbour-dynclock/dynclock.cfg" ]; then
		echo res="128" > /usr/share/harbour-dynclock/dynclock.cfg
	fi
	if [ "$(ls $main/backup/dynclock)" ]; then
		cp $main/backup/dynclock/*.* /usr/share/harbour-dynclock/
	fi
fi

# Set no icon pack
rm $main/icon-current
echo default > $main/icon-current

exit 0
