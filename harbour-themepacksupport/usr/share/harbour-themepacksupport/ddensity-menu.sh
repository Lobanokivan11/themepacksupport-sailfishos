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

# Make sure only root can run the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root. Please gain root privileges and try again." 1>&2
   exit 1
fi

# Set directory variables
main=/usr/share/harbour-themepacksupport


# Check if default Android DPI backup exists

if [ ! -f $main/backup/droiddpi ]; then
   # Look for DPI settings and save them in a backup file
   grep "^ro.sf.lcd_density" /opt/alien/system/build.prop | tr ":" " " | egrep -o '.{1,3}$' > $main/backup/droiddpi
fi

while :
do
    clear
    cat<<EOF
 Theme pack support for Sailfish OS
 ==================================

 Please enter your choice:
 ----------------------------------
   (A)pply device pixel ratio
   (R)estore device pixel ratio
   (C)hange Alien Dalvik DPI
   Restore Alien Dalvik (D)PI
   (B)ack
 ----------------------------------

EOF
    read -n1 -s
    case "$REPLY" in
    "A"|"a")  	read -p "Please enter the device pixel ratio or 'q' to exit and press enter: " choice
		case "$choice" in 
		q|Q ) echo "ok"; sleep 1;;
		* )  su - nemo -c "dconf write /desktop/sailfish/silica/theme_pixel_ratio $choice"
		echo "done!"; sleep 1 ;;
		esac ;;
    "R"|"r")  echo "This will restore your default device pixel ratio. Continue y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) su - nemo -c "dconf reset /desktop/sailfish/silica/theme_pixel_ratio"
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
    "C"|"c")  read -p "Please enter DPI value for Alien Dalvik or 'q' to exit and press enter: " aliensize
		case "$aliensize" in 
		[0-3]* ) # Look for the string in build.prop and apply new value
		sed -i "s/.*ro.sf.lcd_density.*/ro.sf.lcd_density=$aliensize/" /opt/alien/system/build.prop
		echo "done!"; sleep 1 ;;
		q|Q ) echo "quit"; sleep 1 ;;
		esac ;;
    "D"|"d")  echo "This will restore your default DPI in Alien Dalvik. Continue y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) sed -i "s/.*ro.sf.lcd_density.*/ro.sf.lcd_density=$(<$main/backup/droiddpi)/" /opt/alien/system/build.prop
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
     "B"|"b")  exit                      ;;
     * )  echo "invalid option"; sleep 1     ;;
    esac
    sleep 1
done
