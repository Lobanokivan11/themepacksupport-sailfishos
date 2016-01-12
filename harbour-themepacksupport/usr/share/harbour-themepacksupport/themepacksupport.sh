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

# Make sure only root can run the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root. Please gain root privileges and try again." 1>&2
   exit 1
fi

# Set directory variables
main=/usr/share/harbour-themepacksupport

# Load config file
source $main/themepacksupport.cfg

# Is logging set?
# if [ "$tps_log" == "1" ]; then
#	set -x
# elseif [ "$tps_log" == "0" ]; then
#	set +x
# fi

while :
do
    clear
    cat<<EOF
 Theme pack support for Sailfish OS
 =================================

 Please enter your choice:
 ---------------------------------
   (I)con theme
   (F)ont theme BETA
   (S)ound theme
   (H)omescreen refresh
   (U)ninstall theme packs
   (G)uide
   (A)bout
   (Q)uit
 ---------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "I"|"i")  $main/icon-menu.sh ;;
    "F"|"f")  $main/font-menu.sh ;;
    "S"|"s")  $main/sound-menu.sh ;;
    "H"|"h")  echo "Refresh the homescreen? y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) 	echo "Your homescreen will be restarted..."
		systemctl-user restart lipstick.service; echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
    "G"|"g")  clear
cat<<EOF
 Theme pack support for Sailfish OS
 =================================

Usage:

1. Install a compatible theme pack.
2. Apply the theme pack of your choice.
3. Refresh the homescreen.
4. To revert back to defaults use 'Restore' options.

EOF

		read -n1 -r -p "Press any key to continue..." ;;
    "A"|"a")  clear
		cat<<EOF
 Theme pack support for Sailfish OS
 =================================

        \`///oo\`   :
      /oyooyys\` -o/
    :ssssoy+ossys+-
   /oyosssosyo.\`
  .sy+oysos:
  +/sho+sh
      o+sh
      \`yoos:
       \`+-+syo////.
            \`-    :o-
                    +.

Enables theming icons, fonts and sounds in Sailfish OS. Released under GPLv3.

E-mail: fravaccaro90@gmail.com 
Twitter: @fravaccaro

EOF

		read -n1 -r -p "Press any key to continue..." ;;
#    "L"|"l")  echo "Enable logs? y/N? "
#		read -n1 -s choice
#		case "$choice" in 
#		y|Y ) 	echo "Your homescreen will be restarted..."
#		systemctl-user restart lipstick.service; echo "done!"; sleep 1 ;;
#		* ) echo "aborted"; sleep 1 ;;
#		esac ;;
    "U"|"u")  ls -d /usr/share/harbour-themepack-* | sort -u | cut -c30-
		echo " "
		read -p "Please enter the theme pack name you want to uninstall or 'q' to exit and press enter: " choice
		case "$choice" in
		q|Q ) echo "ok"; sleep 1 ;;
		* ) pkcon remove harbour-themepack-$choice ;;
		esac ;;
    "Q"|"q")  clear; exit                      ;;
     * )  echo "invalid option"; sleep 1     ;;
    esac
    sleep 1
done

# Clean tmp files
if [ "$(ls $main/tmp)" ]; then
rm $main/tmp/*
rm $main/icon.menu
rm $main/font.menu
rm $main/sound.menu
fi
