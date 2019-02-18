#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport
system=/etc/dconf/db/vendor.d/locks/

# Save the model in a file
ssu mo | sed 's/.*: //' > $main/device-model

# Set build.prop position
device=$(<$main/device-model)
model=( "h3113" "h3123" "h3133" "h4113" "h4133" "h3413" "h4413" "h4493" "h3213" "h3223" "h4213" "h4233" )
if [[ " ${model[*]} " == *" $device "* ]]; then
	if [ -f /vendor/build.prop ]; then
		dir_droid=/vendor
	fi
else
	dir_droid=/opt/alien/system
fi

mkdir -p $main/tmp
mkdir -p $main/backup
mkdir -p $main/backup/dlocks

if [ -f $system/silica-configs.txt ]; then
	mv $system/silica-configs.txt $main/backup/dlocks/silica-configs.txt.bk
fi

if [ -f $system/ui-configs.txt ]; then
	mv $system/ui-configs.txt $main/backup/dlocks/ui-configs.txt.bk
fi

dconf update

dconf read /desktop/sailfish/silica/icon_size_launcher | egrep -o '[0-9].[0-9]+' > $main/icon-z

if [ -d "$dir_droid" ]; then
	grep "^ro.sf.lcd_density" $dir_droid/build.prop | tr ":" " " | egrep -o '.{1,3}$' > $main/droiddpi-current
fi

exit 0
