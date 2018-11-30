#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport
backup=/usr/share/harbour-themepacksupport/backup
system=/etc/dconf/db/vendor.d
dir_droid=/opt/alien/system

if [ -f $system/silica-configs.txt ]; then
	mv $system/silica-configs.txt $backup/vendord/silica-configs.txt.bk
fi

if [ -f $system/locks/silica-configs.txt ]; then
	mv $system/locks/silica-configs.txt $backup/dlocks/silica-configs.txt.bk
fi

if [ -f $system/locks/ui-configs.txt ]; then
	mv $system/locks/ui-configs.txt $backup/dlocks/ui-configs.txt.bk
fi

dconf update

dconf read /desktop/sailfish/silica/icon_size_launcher | egrep -o '[0-9].[0-9]+' > $main/icon-z

if [ -d "$dir_droid" ]; then
	grep "^ro.sf.lcd_density" $dir_droid/build.prop | tr ":" " " | egrep -o '.{1,3}$' > $main/droiddpi-current
fi

exit 0
