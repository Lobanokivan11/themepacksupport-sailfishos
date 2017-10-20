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

# List Jolla icons z1.0
cp $dir_jolla/z1.0/icons/* $main/backup/jolla/z1.0/icons/

if [ -d "$dir_jolla/z1.25" ]; then
cp $dir_jolla/z1.25/icons/* $main/backup/jolla/z1.25/icons/
fi

if [ -d "$dir_jolla/z1.5" ]; then
cp $dir_jolla/z1.5/icons/* $main/backup/jolla/z1.5/icons/
fi

if [ -d "$dir_jolla/z1.5-large" ]; then
cp $dir_jolla/z1.5-large/icons/* $main/backup/jolla/z1.5-large/icons/
fi

if [ -d "$dir_jolla/z1.75" ]; then
cp $dir_jolla/z1.75/icons/* $main/backup/jolla/z1.75/icons/
fi

if [ -d "$dir_jolla/z2.0" ]; then
cp $dir_jolla/z2.0/icons/* $main/backup/jolla/z2.0/icons/
fi

# List native icons 86x86
cp $dir_native/86x86/apps/* $main/backup/native/86x86/apps/

# List native icons 108x108
cp $dir_native/108x108/apps/* $main/backup/native/108x108/apps/

# List native icons 128x128
cp $dir_native/128x128/apps/* $main/backup/native/128x128/apps/

# List native icons 256x256
cp $dir_native/256x256/apps/* $main/backup/native/256x256/apps/

# If Android support is installed
if [ -d "$dir_apk" ]; then
	cp $dir_apk/* $main/backup/apk/
fi

# If DynCal is installed 
if [ -d "/usr/share/harbour-dyncal" ]; then
	cp /usr/share/harbour-dyncal/icons/*.* $main/backup/dyncal/
fi

# If DynClock is installed 
if [ -d "/usr/share/harbour-dynclock" ]; then
	cp /usr/share/harbour-dynclock/*.png $main/backup/dynclock/
fi

exit 0
