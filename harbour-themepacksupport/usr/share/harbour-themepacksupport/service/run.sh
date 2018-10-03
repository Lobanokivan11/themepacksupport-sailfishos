#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport
iconpack=$(<$main/icon-current)
pack=/usr/share/harbour-themepack-$iconpack
dir_native=/usr/share/icons/hicolor
dir_apk=/var/lib/apkd
sizen=$(du -sb $dir_native | cut -f1)
sizea=$(du -sb $dir_apk | cut -f1)

if [ "$iconpack" == "default" ]; then
	exit 1
fi

if [[ "$sizen" == "$(<$main/size_native)" ]]; then
	exit 1
fi

echo $sizen > $main/size_native
# RESTORE THEME
# Native icons
nativeCap=( "256x256" "128x128" "108x108" "86x86" )

for ((i=0;i<${#nativeCap[@]};++i)); do
	# Perform copy of existing icons
	for file in $dir_native/${nativeCap[i]}/apps/*.png; do
		if test -e "$main/backup/native/${nativeCap[i]}/apps/$(basename ${file})"
			then cp "$main/backup/native/${nativeCap[i]}/apps/$(basename ${file})" "${file}"
		fi
	done
done

# If Android support is installed
if [ -d "$dir_apk" ]; then
	for file in $dir_apk/*.png; do
		if test -e "$main/backup/apk/$(basename ${file})"
			then cp "$main/backup/apk/$(basename ${file})" "${file}"
		fi
	done
fi

# BACKUP THEME
# Native icons
nativeCap=( "256x256" "128x128" "108x108" "86x86" )

for ((i=0;i<${#nativeCap[@]};++i)); do
	# Perform copy of existing icons
	cp $dir_native/${nativeCap[i]}/apps/*.png $main/backup/native/${nativeCap[i]}/apps/
done

# If Android support is installed
if [ -d "$dir_apk" ]; then
	cp $dir_apk/*.png $main/backup/apk/
fi

# APPLY THEME
# Native icons
nativeCap=( "256x256" "128x128" "108x108" "86x86" )

for ((i=0;i<${#nativeCap[@]};++i)); do
for ((j=i;j<${#nativeCap[@]};++j)); do
	# if there are native icons
	if [ -d $pack/native/${nativeCap[j]}/apps ]; then
		# Perform copy of existing icons
		for file in $dir_native/${nativeCap[i]}/apps/*.png; do
			if test -e "$pack/native/${nativeCap[j]}/apps/$(basename ${file})"
				then cp "$pack/native/${nativeCap[j]}/apps/$(basename ${file})" "${file}"
			fi
		done
	break
	fi
done
done

# If Android support is installed
if [ -d "$dir_apk" ]; then

apkCap=( "128x128" "86x86" )

for ((i=0;i<${#apkCap[@]};++i)); do
for ((j=i;j<${#apkCap[@]};++j)); do
	# if there are native icons
	if [ -d $pack/apk/${apkCap[j]} ]; then
		# Perform copy of existing icons
		for file in $dir_apk/*.png; do
			if test -e "$pack/apk/${apkCap[j]}/$(basename ${file})"
				then cp "$pack/apk/${apkCap[j]}/$(basename ${file})" "${file}"
			fi
		done
	break
	fi
done
done

fi
