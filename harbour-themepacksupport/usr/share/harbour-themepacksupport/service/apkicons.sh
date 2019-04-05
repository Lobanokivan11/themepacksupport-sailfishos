#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport
iconpack=$(<$main/icon-current)
pack=/usr/share/harbour-themepack-$iconpack
dir_jolla=/usr/share/themes/sailfish-default/meegotouch
dir_native=/usr/share/icons/hicolor
dir_apk=/var/lib/apkd

# If Android support is installed
if [ -d "$dir_apk" ]; then

	if [ -d $main/backup/apk/ ]; then
		rsync -a --existing --ignore-times $main/backup/apk/ $dir_apk/
	fi
	rsync -a --existing --ignore-times $main/backup/icons/apk/ $dir_apk/

$main/icon-backup.sh

apkCap=( "192x192" "128x128" "86x86" )

for ((i=0;i<${#apkCap[@]};++i)); do
for ((j=i;j<${#apkCap[@]};++j)); do
	# if there are native icons
	if [ -d $pack/apk/${apkCap[j]} ]; then
		# Perform copy of existing icons
		rsync -a --existing $pack/apk/${apkCap[j]}/ $dir_apk/
		break 3
	fi
done
done

fi

if [[ -d $pack/overlay && "$(ls $pack/overlay)" ]]; then

    echo "apply overlay"
    $main/icon-overlay.sh $iconpack

fi

touch /usr/share/applications/*.desktop

exit 0
