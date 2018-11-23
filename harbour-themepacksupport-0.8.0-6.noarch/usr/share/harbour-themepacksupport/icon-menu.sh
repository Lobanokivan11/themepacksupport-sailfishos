#!/bin/bash

# Make sure only root can run the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root. Please gain root privileges and try again." 1>&2
   exit 1
fi

# Set directory variables
main=/usr/share/harbour-themepacksupport

# Generate menu
find /usr/share/harbour-themepack-* -maxdepth 1 -type d -iname "jolla" -printf "%h\n" | sort -u | cut -c30- > $main/tmp/icon-tmp1
find /usr/share/harbour-themepack-* -maxdepth 1 -type d -iname "native" -printf "%h\n" | sort -u | cut -c30- > $main/tmp/icon-tmp2
find /usr/share/harbour-themepack-* -maxdepth 1 -type d -iname "apk" -printf "%h\n" | sort -u | cut -c30- > $main/tmp/icon-tmp3
find /usr/share/harbour-themepack-* -maxdepth 1 -type d -iname "dyncal" -printf "%h\n" | sort -u | cut -c30- > $main/tmp/icon-tmp4
find /usr/share/harbour-themepack-* -maxdepth 1 -type d -iname "dynclock" -printf "%h\n" | sort -u | cut -c30- > $main/tmp/icon-tmp5
cat $main/tmp/icon-tmp* | sort | uniq > $main/icon.menu

find /usr/share/harbour-themepack-* -maxdepth 1 -type d -iname "overlay" -printf "%h\n" | sort -u | cut -c30- > $main/overlay.menu

while :
do
    clear
    cat<<EOF
 Theme pack support for Sailfish OS
 ==================================

 Please enter your choice:
 ----------------------------------
   (A)pply icon theme
   Icon (O)verlay
   (R)estore
   Auto-(U)pdate icon theme
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
		* ) $main/icon-restore.sh
		$main/icon-backup.sh
		$main/icon-run.sh $choice
		echo "done!"; sleep 1 ;;
		esac ;;
    "O"|"o")  cat $main/overlay.menu
		echo " "
		read -p "If you want to apply an overlay for icons not available the theme enter the icon pack name or 'q' to exit and press enter: " choice
		case "$choice" in 
		q|Q ) echo "ok"; sleep 1;;
		* ) $main/icon-overlay.sh $choice
		echo "done!"; sleep 1 ;;
		esac ;;
    "R"|"r")  echo "This will restore your default icon pack. Continue y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) $main/icon-restore.sh
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
     "U"|"u")  $main/autoupdate-menu.sh ;;
     "B"|"b")  rm -r $main/tmp/*; exit                      ;;
     * )  echo "invalid option"; sleep 1     ;;
    esac
    sleep 1
done
