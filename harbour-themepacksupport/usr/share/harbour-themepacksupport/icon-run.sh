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

# Usage ./run.sh [iconpackname]

# Set icon pack name variable
iconpack=$1
# Is the variable empty?
if [ -z "$iconpack" ]; then
    exit 1
fi

# Set directory variables
main=/usr/share/harbour-themepacksupport
pack=/usr/share/harbour-themepack-$iconpack
dir_jolla=/usr/share/themes/sailfish-default/meegotouch
dir_native=/usr/share/icons/hicolor
dir_apk=/var/lib/apkd

# Check if a backup has been performed
#if [ ! "$(ls $main/backup/jolla)" -o ! "$(ls $main/backup/native)" -o ! "$(ls $main/backup/apk)" -o ! "$(ls $main/backup/dyncal)" -o ! "$(ls $main/backup/dynclock)" ]; then
#	echo "Run backup first!"
#	exit 1
#fi

# Jolla icons
jollaCap=( "z2.0" "z1.75" "z1.5-large" "z1.5" "z1.25" "z1.0" )

for ((i=0;i<${#jollaCap[@]};++i)); do
for ((j=i;j<${#jollaCap[@]};++j)); do
	# if there are Jolla icons
	if [ -d $pack/jolla/${jollaCap[j]}/icons ]; then
		# Perform copy of existing icons
		for file in $dir_jolla/${jollaCap[i]}/icons/*.png; do
			if test -e "$pack/jolla/${jollaCap[j]}/icons/$(basename ${file})"
				then cp "$pack/jolla/${jollaCap[j]}/icons/$(basename ${file})" "${file}"
			fi
		done
	break
	fi
done
done

# Native icons
nativeCap=( "256x256" "128x128" "108x108" "86x86" )

for ((i=0;i<${#nativeCap[@]};++i)); do
for ((j=i;j<${#nativeCap[@]};++j)); do
	# if there are native icons
	if [ -d $pack/native/${nativeCap[j]}/apps ]; then
		# Perform copy of existing icons
		for file in $dir_native/${nativeCap[i]}/apps/*.png; do
			if test -e "$pack/native/${nativeCap[j]}/apps/$(basename ${file})"
				then cp "$pack/native/${nativeCap[j]}/apps/$(basename ${file})" "${file}"
			fi
		done
	break
	fi
done
done

# If Android support is installed
if [ -d "$dir_apk" ]; then

apkCap=( "128x128" "86x86" )

for ((i=0;i<${#apkCap[@]};++i)); do
for ((j=i;j<${#apkCap[@]};++j)); do
	# if there are native icons
	if [ -d $pack/apk/${apkCap[j]} ]; then
		# Perform copy of existing icons
		for file in $dir_apk/*.png; do
			if test -e "$pack/apk/${apkCap[j]}/$(basename ${file})"
				then cp "$pack/apk/${apkCap[j]}/$(basename ${file})" "${file}"
			fi
		done
	break
	fi
done
done

fi

# If DynCal is installed
if [ -d "/usr/share/harbour-dyncal" ]; then
	# Check if there are DynCal icons
	if [ -d "$pack/dyncal/86x86" ]; then
		rm -rf /usr/share/harbour-dyncal/icons/*
		cp $pack/dyncal/86x86/*.* /usr/share/harbour-dyncal/icons/
		sh /usr/share/harbour-dyncal/harbour-dyncal.sh
	fi
fi

# If DynClock is installed
if [ -d "/usr/share/harbour-dynclock" ]; then
	# Check if there are DynClock icons
	if [ -d "$pack/dynclock/86x86" ]; then
		cp $pack/dynclock/86x86/*.* /usr/share/harbour-dynclock/
		echo res="43" > /usr/share/harbour-dynclock/dynclock.cfg
		sh /usr/share/harbour-dynclock/harbour-dynclock.sh
	fi
fi

# Save current icon pack
rm $main/icon-current
echo $iconpack > $main/icon-current

# Re-enable service if enabled
if [[ "$(sed -n 2p $main/themepacksupport.cfg)" =~ "1" ]]; then
	systemctl enable harbour-themepacksupport.timer
	systemctl start harbour-themepacksupport.timer
	systemctl enable harbour-themepacksupport.service
	systemctl start harbour-themepacksupport.service
fi

exit 0
