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

# Usage ./run.sh [soundpackname]

# Set sound pack name variable
soundpack=$1
# Is the variable empty?
if [ -z "$soundpack" ]; then
    exit 1
fi

# Set directory variables
main=/usr/share/harbour-themepacksupport
pack=/usr/share/harbour-themepack-$soundpack
dir_jolla=/usr/share/sounds/jolla-ambient/stereo

# Check if a backup has been performed
if [ "$(ls $main/backup/sound)" ]; then

# Check if there are Jolla sounds
if [ -d "$pack/sound" ]; then
	cp $pack/sound/*.wav $dir_jolla/
fi

# Clean tmp directory
if [ "$(ls $main/tmp)" ]; then
	rm $main/tmp/*
fi

# Save current sound pack
rm $main/sound-current
echo $iconpack > $main/sound-current

# Warm about backup not performed
else
echo "Run backup first!"
fi
exit 0
