#!/bin/bash
#
#    Theme pack support for Sailfish OS - Enables theme pack support in Sailfish OS.
#    Copyright (C) 2015  fravaccaro fravaccaro90@gmail.com
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
dir_jolla=/usr/share/themes/jolla-ambient/meegotouch
dir_native=/usr/share/icons/hicolor
dir_apk=/var/lib/apkd

# Check if a backup has been performed
if [ "$(ls $main/backup/jolla)" -o "$(ls $main/backup/native)" -o "$(ls $main/backup/apk)" -o "$(ls $main/backup/dyncal)" -o "$(ls $main/backup/dynclock)" ]; then

# List backuped Jolla icons z1.0
ls $main/backup/jolla/z1.0/icons > $main/tmp/bk_jolla1
# List Jolla icons
ls $dir_jolla/z1.0/icons > $main/tmp/sys_jolla1
#Check if there are common icons
comm -1 -2 $main/tmp/bk_jolla1 $main/tmp/sys_jolla1 > $main/tmp/cp_jolla1
if [ -s "$main/tmp/cp_jolla1" ]; then
	# Restore Jolla icons
	for file in $(<$main/tmp/cp_jolla1); do cp "$main/backup/jolla/z1.0/icons/$file" $dir_jolla/z1.0/icons/; done
fi

if [ -d "$dir_jolla/z1.5" ]; then
# List backuped Jolla icons z1.5
ls $main/backup/jolla/z1.5/icons > $main/tmp/bk_jolla15
# List Jolla icons
ls $dir_jolla/z1.5/icons > $main/tmp/sys_jolla15
#Check if there are common icons
comm -1 -2 $main/tmp/bk_jolla15 $main/tmp/sys_jolla15 > $main/tmp/cp_jolla15
if [ -s "$main/tmp/cp_jolla15" ]; then
	# Restore Jolla icons
	for file in $(<$main/tmp/cp_jolla15); do cp "$main/backup/jolla/z1.5/icons/$file" $dir_jolla/z1.5/icons/; done
fi
fi

if [ -d "$dir_jolla/z2.0" ]; then
# List backuped Jolla icons z2.0
ls $main/backup/jolla/z2.0/icons > $main/tmp/bk_jolla2
# List Jolla icons
ls $dir_jolla/z2.0/icons > $main/tmp/sys_jolla2
#Check if there are common icons
comm -1 -2 $main/tmp/bk_jolla2 $main/tmp/sys_jolla2 > $main/tmp/cp_jolla2
if [ -s "$main/tmp/cp_jolla2" ]; then
	# Restore Jolla icons
	for file in $(<$main/tmp/cp_jolla2); do cp "$main/backup/jolla/z2.0/icons/$file" $dir_jolla/z2.0/icons/; done
fi
fi

# List backuped native icons 86x86
ls $main/backup/native/86x86/apps > $main/tmp/bk_native86
# List native icons
ls $dir_native/86x86/apps > $main/tmp/sys_native86
#Check if there are common icons
comm -1 -2 $main/tmp/bk_native86 $main/tmp/sys_native86 > $main/tmp/cp_native86
if [ -s "$main/tmp/cp_native86" ]; then
	# Restore native icons
	for file in $(<$main/tmp/cp_native86); do cp "$main/backup/native/86x86/apps/$file" $dir_native/86x86/apps; done
fi

# List backuped native icons 108x108
ls $main/backup/native/108x108/apps > $main/tmp/bk_native108
# List native icons
ls $dir_native/108x108/apps > $main/tmp/sys_native108
#Check if there are common icons
comm -1 -2 $main/tmp/bk_native108 $main/tmp/sys_native108 > $main/tmp/cp_native108
if [ -s "$main/tmp/cp_native108" ]; then
	# Restore native icons
	for file in $(<$main/tmp/cp_native108); do cp "$main/backup/native/108x108/apps/$file" $dir_native/108x108/apps; done
fi

# List backuped native icons 128x128
ls $main/backup/native/128x128/apps > $main/tmp/bk_native128
# List native icons
ls $dir_native/128x128/apps > $main/tmp/sys_native128
#Check if there are common icons
comm -1 -2 $main/tmp/bk_native128 $main/tmp/sys_native128 > $main/tmp/cp_native128
if [ -s "$main/tmp/cp_native128" ]; then
	# Restore native icons
	for file in $(<$main/tmp/cp_native128); do cp "$main/backup/native/128x128/apps/$file" $dir_native/128x128/apps; done
fi

# List backuped native icons 256x256
ls $main/backup/native/256x256/apps > $main/tmp/bk_native256
# List native icons
ls $dir_native/256x256/apps > $main/tmp/sys_native256
#Check if there are common icons
comm -1 -2 $main/tmp/bk_native256 $main/tmp/sys_native256 > $main/tmp/cp_native256
if [ -s "$main/tmp/cp_native256" ]; then
	# Restore native icons
	for file in $(<$main/tmp/cp_native256); do cp "$main/backup/native/256x256/apps/$file" $dir_native/256x256/apps; done
fi

# If Android support is installed
if [ -d "$dir_apk" ]; then
	# List backuped Android icons
	ls $main/backup/apk/86x86 > $main/tmp/bk_apk
	# List Android icons
	ls $dir_apk > $main/tmp/sys_apk
	#Check if there are common icons
	comm -1 -2 $main/tmp/bk_apk $main/tmp/sys_apk > $main/tmp/cp_apk
	if [ -s "$main/tmp/cp_apk" ]; then
		# Restore Android icons
		for file in $(<$main/tmp/cp_apk); do cp "$main/backup/apk/86x86/$file" $dir_apk; done
	fi
fi

# If DynCal is installed
if [ -d "/usr/share/harbour-dyncal" ]; then
	if [ "$(ls $main/backup/dyncal/86x86)" ]; then
		cp $main/backup/dyncal/86x86/*.* /usr/share/harbour-dyncal/icons/
	fi
fi

# If DynClock is installed
if [ -d "/usr/share/harbour-dynclock" ]; then
	if [ "$(ls $main/backup/dynclock/86x86)" ]; then
		cp $main/backup/dynclock/86x86/*.* /usr/share/harbour-dynclock/
	fi
fi

# Remove backuped Jolla icons
if [ "$(ls $main/backup/jolla)" ]; then
	rm -rf $main/backup/jolla/*
fi
# Remove backuped native icons
	if [ "$(ls $main/backup/native)" ]; then
rm -rf $main/backup/native/*
fi
# If Android support is installed
if [ -d "$dir_apk" ]; then
	# Remove backuped Android icons
	if [ "$(ls $main/backup/apk)" ]; then
		rm -rf $main/backup/apk/*
	fi
fi
# If DynCal is installed
if [ -d "/usr/share/harbour-dyncal" ]; then
	# Remove backuped DynCal icons
	if [ "$(ls $main/backup/dyncal)" ]; then
		rm -rf $main/backup/dyncal/*
	fi
fi
# If DynClock is installed
if [ -d "/usr/share/harbour-dynclock" ]; then
	# Remove backuped DynClock icons
	if [ "$(ls $main/backup/dynclock)" ]; then
		rm -rf $main/backup/dynclock/*
	fi
fi

# Clean tmp directory
rm $main/tmp/*

# Set no icon pack
rm $main/icon-current
echo default > $main/icon-current

fi

exit 0