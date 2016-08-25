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
dir_jolla=/usr/share/themes/sailfish-default/meegotouch/icons

# Check if a backup has been performed
if [ "$(ls $main/backup/graphic)"  ]; then

# Check if there are graphic icons
if [ -d "$pack/graphic" ]; then

# Check if there are graphic icons
	if [ "$(ls $pack/graphic)" ]; then
		# List icon pack icons
		ls $pack/graphic > $main/tmp/pack_graphic
		# List graphic icons
		ls $dir_jolla > $main/tmp/sys_graphic
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_graphic $main/tmp/sys_graphic > $main/tmp/cp_graphic
		if [ -s "$main/tmp/cp_graphic" ]; then
			# Copy selected graphic icon pack
			for file in $(<$main/tmp/cp_graphic); do cp "$pack/graphic/$file" $dir_jolla; done
		fi
	fi

# Clean tmp directory
if [ "$(ls $main/tmp)" ]; then
	rm $main/tmp/*
fi

# Save current icon pack
rm $main/graphic-current
echo $iconpack > $main/graphic-current

# Warm about backup not performed
else
echo "Run backup first!"

fi
fi

exit 0
