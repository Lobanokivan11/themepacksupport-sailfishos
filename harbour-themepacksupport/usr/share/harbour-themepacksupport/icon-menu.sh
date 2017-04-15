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

# Generate menu
		cd /usr/share/; 
find harbour-themepack-* -maxdepth 1 -type d -iname "jolla" -printf "%h\n" | sort -u | cut -c19- > $main/tmp/icon-tmp1
find harbour-themepack-* -maxdepth 1 -type d -iname "native" -printf "%h\n" | sort -u | cut -c19- > $main/tmp/icon-tmp2
find harbour-themepack-* -maxdepth 1 -type d -iname "apk" -printf "%h\n" | sort -u | cut -c19- > $main/tmp/icon-tmp3
find harbour-themepack-* -maxdepth 1 -type d -iname "dyncal" -printf "%h\n" | sort -u | cut -c19- > $main/tmp/icon-tmp4
find harbour-themepack-* -maxdepth 1 -type d -iname "dynclock" -printf "%h\n" | sort -u | cut -c19- > $main/tmp/icon-tmp5
cat $main/tmp/icon-tmp* | sort | uniq > $main/icon.menu

while :
do
    clear
    cat<<EOF
 Theme pack support for Sailfish OS
 ==================================

 Please enter your choice:
 ----------------------------------
   (A)pply icon theme
   (R)estore
   (B)ack
 ----------------------------------
 Current icon pack: $(<$main/icon-current)

EOF
    read -n1 -s
    case "$REPLY" in
    "A"|"a")  cat $main/icon.menu
		echo " "
		read -p "Please enter the icon pack name or 'q' to exit and press enter: " choice
		case "$choice" in 
		q|Q ) echo "ok"; sleep 1;;
		* ) # Check if a backup has been performed
		if [ "$(ls $main/backup/jolla)" -o "$(ls $main/backup/native)" -o "$(ls $main/backup/apk)" -o "$(ls $main/backup/dyncal)" -o "$(ls $main/backup/dynclock)" ]; then
		$main/icon-restore.sh
		$main/icon-backup.sh
		$main/icon-run.sh $choice
		else
		$main/icon-backup.sh
		$main/icon-run.sh $choice
		fi
		echo "done!"; sleep 1 ;;
		esac ;;
    "R"|"r")  echo "This will restore your default icon pack. Continue y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) $main/icon-restore.sh
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
     "B"|"b")  exit                      ;;
     * )  echo "invalid option"; sleep 1     ;;
    esac
    sleep 1
done
