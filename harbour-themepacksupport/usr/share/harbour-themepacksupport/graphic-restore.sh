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
dir_jolla=/usr/share/themes/sailfish-default/meegotouch/icons

# Check if a backup has been performed
if [ "$(ls $main/backup/graphic)" ]; then

# List backuped graphic icons
ls $main/backup/graphic > $main/tmp/bk_graphic
# List graphic icons
ls $dir_jolla/ > $main/tmp/sys_graphic
#Check if there are common icons
comm -1 -2 $main/tmp/bk_graphic $main/tmp/sys_graphic > $main/tmp/cp_graphic
if [ -s "$main/tmp/cp_graphic" ]; then
	# Restore Jolla icons
	for file in $(<$main/tmp/cp_graphic); do cp "$main/backup/graphic/$file" $dir_jolla; done
fi

# Clean tmp directory
rm $main/tmp/*
if [ -s "$main/backup/cp_graphic*" ]; then
	rm $main/backup/cp_graphic*
fi

# Set no icon pack
rm $main/graphic-current
echo default > $main/graphic-current

fi

exit 0
