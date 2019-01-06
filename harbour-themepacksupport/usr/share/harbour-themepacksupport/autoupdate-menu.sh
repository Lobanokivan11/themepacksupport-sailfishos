#!/bin/bash

# Make sure only root can run the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root. Please gain root privileges and try again." 1>&2
   exit 1
fi

# Set directory variables
main=/usr/share/harbour-themepacksupport

function load-service {
if [[ "$(sed -n 2p $main/themepacksupport.cfg)" =~ "1" ]]; then
    systemctl daemon-reload
else
    $main/enable-autoupdate.sh
fi
}

while :
do
    clear
    cat<<EOF
 Theme pack support for Sailfish OS
 ==================================

 Please enter your choice:
 ----------------------------------
   (S)et auto-update
   (D)isable auto-update
   (B)ack
 ----------------------------------

EOF
    read -n1 -s
    case "$REPLY" in
    "S"|"s")      cat<<EOF
1) 30 minutes
2) 1 hour
3) 2 hours
4) 3 hours
5) 6 hours
6) 12 hours
7) daily
EOF
			read -p "Please choose your favorite option or 'q' to exit and press enter: " hrs
			case "$hrs" in
    "1")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=*-*-* *:0/30
Persistent=true
OnActiveSec=30m

[Install]
WantedBy=timers.target' > /etc/systemd/system/themepacksupport-autoupdate.timer		load-service
		echo "done!"; sleep 1 ;;
    "2")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=hourly
Persistent=true
OnActiveSec=1h

[Install]
WantedBy=timers.target' > /etc/systemd/system/themepacksupport-autoupdate.timer 
		load-service
		echo "done!"; sleep 1 ;;
    "3")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=2h
Persistent=true
OnActiveSec=2h

[Install]
WantedBy=timers.target' > /etc/systemd/system/themepacksupport-autoupdate.timer
		load-service
		echo "done!"; sleep 1 ;;
    "4")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=3h
Persistent=true
OnActiveSec=3h

[Install]
WantedBy=timers.target' > /etc/systemd/system/themepacksupport-autoupdate.timer
		load-service
		echo "done!"; sleep 1 ;;
    "5")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=6h
Persistent=true
OnActiveSec=6h

[Install]
WantedBy=timers.target' > /etc/systemd/system/themepacksupport-autoupdate.timer
		load-service
		echo "done!"; sleep 1 ;;
    "6")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=12h
Persistent=true
OnActiveSec=12h

[Install]
WantedBy=timers.target' > /etc/systemd/system/themepacksupport-autoupdate.timer
		load-service
		echo "done!"; sleep 1 ;;
    "7")  read -p "Please enter the hour of your choice in the format hh:mm eg 18:20 and press enter: " choice
echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar='$choice'
Persistent=true
OnActiveSec=24h

[Install]
WantedBy=timers.target' > /etc/systemd/system/themepacksupport-autoupdate.timer
echo $hrs > $main/service/hours
		load-service
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
    "D"|"d")  echo "Disable auto-update icons y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) $main/disable-autoupdate.sh
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
     "B"|"b")  exit                      ;;
     * )  echo "invalid option"; sleep 1     ;;
    esac
    sleep 1
done
