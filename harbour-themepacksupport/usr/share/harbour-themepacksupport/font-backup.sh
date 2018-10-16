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
dir_jolla=/usr/share/fonts
dir_apk=/opt/alien/system/fonts

# Copy Jolla fonts
cp -R $dir_jolla/* $main/backup/font/

# If Android support is installed
if [ -d "$dir_apk" ]; then
	# Copy Android fonts
	cp -R $dir_apk/* $main/backup/font-droid/
fi

exit 0
