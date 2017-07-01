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

function timer-changer {
	timer=$(<$main/service/hours)
	echo '[Unit]
Description=Update icon theme via Theme pack support.

[Timer]
OnBootSec=0
OnCalendar=*-*-* '$timer'
Persistent=true

[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer
}

while :
do
    clear
    cat<<EOF
 Theme pack support for Sailfish OS
 ==================================

 Please enter your choice:
 ----------------------------------
   (E)nable auto-update
   (S)et hours
   (D)isable auto-update
   (B)ack
 ----------------------------------

EOF
    read -n1 -s
    case "$REPLY" in
    "E"|"e")  echo "Enable auto-update icons y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) if [[ ! -s $main/service/hours ]]; then
			read -p "Please enter the desided hours in the format hh:mm separated by a comma, eg 06:00,18:20 and press enter: " hrs
			echo $hrs > $main/service/hours
			timer-changer
		fi
		systemctl enable harbour-themepacksupport.timer
		systemctl start harbour-themepacksupport.timer
		systemctl enable harbour-themepacksupport.service
		systemctl start harbour-themepacksupport.service
		sed -i "s/.*tps_service.*/tps_service='1'/" $main/themepacksupport.cfg
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
    "S"|"s")  read -p "Please enter the desider hours in the format hh:mm separated by a comma, eg 06:00,18:20 or 'q' to exit and press enter: " choice
		case "$choice" in 
		q|Q ) echo "ok"; sleep 1;;
		* ) echo $choice > $main/service/hours
		timer-changer
		if [[ "$(sed -n 2p $main/themepacksupport.cfg)" =~ "1" ]]; then
			systemctl daemon-reload
		fi		
		echo "done!"; sleep 1 ;;
		esac ;;
    "D"|"d")  echo "Disable auto-update icons y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) systemctl disable harbour-themepacksupport.timer
		systemctl stop harbour-themepacksupport.timer
		systemctl disable harbour-themepacksupport.service
		systemctl stop harbour-themepacksupport.service
		sed -i "s/.*tps_service.*/tps_service='0'/" $main/themepacksupport.cfg
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
     "B"|"b")  exit                      ;;
     * )  echo "invalid option"; sleep 1     ;;
    esac
    sleep 1
done
