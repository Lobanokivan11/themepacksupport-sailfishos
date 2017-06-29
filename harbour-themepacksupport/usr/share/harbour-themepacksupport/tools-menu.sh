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

while :
do
    clear
    cat<<EOF
 Theme pack support for Sailfish OS
 ==================================

 Please enter your choice:
 ----------------------------------
   Unapply (A)ll Patchmanager patches
   Uninstall (P)atchmanager 
   Reinstall (U)I
   Reinstall (I)cons
   Reinstall (F)onts
   (B)ack
 ----------------------------------

EOF
    read -n1 -s
    case "$REPLY" in
    "A"|"a")  echo "This will unapply all Patchmanager patches. Continue y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) patchmanager --unapply-all
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
    "P"|"p")  echo "This will uninstall Patchmanager and restore the Sailfish OS UI. Continue y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) patchmanager --unapply-all
		pkcon remove ausmt
		pkcon install zypper
		zypper install -f lipstick-qt5 lipstick-jolla-home-qt5 jolla-settings jolla-settings-system
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
    "U"|"u")  echo "This will restore the Sailfish OS UI. Continue y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) pkcon install zypper
		zypper install -f lipstick-qt5 lipstick-jolla-home-qt5 jolla-settings jolla-settings-system
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
    "I"|"i")  echo "This will restore the default Sailfish OS icons. Continue y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) $main/icon-reinstall.sh
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
    "F"|"f")  echo "This will restore the default Sailfish OS fonts. Continue y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) $main/font-restore.sh
		pkcon install sailfish-fonts
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
     "B"|"b")  exit                      ;;
     * )  echo "invalid option"; sleep 1     ;;
    esac
    sleep 1
done
