#!/bin/bash

# Usage ./run.sh [iconpackname]

# Set icon pack name variable
 iconpack=$1
# Is the variable empty?
 if [ -z "$iconpack" ]; then
     exit 1
 fi

# Set directory variables
main=/usr/share/harbour-themepacksupport
pack=/usr/share/harbour-themepack-$iconpack
dir_jolla=/usr/share/themes/sailfish-default/meegotouch
dir_native=/usr/share/icons/hicolor
dir_apk=/var/lib/apkd

# Clean tmp directory
rm -r $main/tmp/*

# Native icons
if [[ ! -f $pack/type || $(<$pack/type) != "android" ]]; then

nativeCap=( "256x256" "128x128" "108x108" "86x86" )

for ((i=0;i<${#nativeCap[@]};++i)); do
	# if there are native icons
	if [ -d $pack/native/${nativeCap[i]}/apps ]; then
		# List icons not in the theme
		diff -r $dir_native/${nativeCap[i]}/apps $pack/native/${nativeCap[i]}/apps | grep 'Only in /usr/share/icons' | awk '{print $4}' > $main/tmp/${nativeCap[i]}
	fi
done

for ((i=0;i<${#nativeCap[@]};++i)); do

	for file in $(<$main/tmp/${nativeCap[i]}); do 
	# Convert icons with ImageMagick
	find $pack/overlay/ -type f -name "*.png" | shuf -n 1 |\
	   convert \( @- -scale ${nativeCap[i]} -gravity Center \) \( $dir_native/${nativeCap[i]}/apps/$file -scale 60%x60% -gravity Center \) -composite -gravity Center -geometry ${nativeCap[i]} $main/tmp/$file
	# Move icons
	mv "$main/tmp/$file" $dir_native/${nativeCap[i]}/apps

	done

done

# Clean tmp directory
rm -r $main/tmp/*

fi

# if there are Android icons
if [ -d $pack/apk/86x86 ]; then
	# List icons not in the theme
	diff -r $dir_apk $pack/apk/86x86 | grep 'Only in /var/lib/apkd' | awk '{print $4}' > $main/tmp/86x86
fi

if [[ ! -f $main/tmp/86x86 && $(<$pack/type) == "android" ]]; then
   ls $dir_apk > $main/tmp/86x86
fi

for file in $(<$main/tmp/86x86); do 
# Convert icons with ImageMagick
find $pack/overlay/ -type f -name "*.png" | shuf -n 1 |\
   convert \( @- -scale 86x86 -gravity Center \) \( $dir_apk/$file -scale 55x55 -gravity Center \) -composite -gravity Center -geometry 86x86 $main/tmp/$file
# Move icons
mv "$main/tmp/$file" $dir_apk
done
