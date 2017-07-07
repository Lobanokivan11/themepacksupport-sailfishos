#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport
iconpack=$(<$main/icon-current)
pack=/usr/share/harbour-themepack-$iconpack
dir_native=/usr/share/icons/hicolor
dir_apk=/var/lib/apkd
sizen=$(du -sb $dir_native | cut -f1)
sizea=$(du -sb $dir_apk | cut -f1)

if [ "$pack" == "default" ]; then
	exit 1
fi

if [[ "$sizen" != "$(<$main/size_native)" ]]; then
	echo $sizen > $main/size_native
	# RESTORE THEME
	# List backuped native icons 86x86
	ls $main/backup/native/86x86/apps > $main/tmp/bk_native86
	# List native icons
	ls $dir_native/86x86/apps > $main/tmp/sys_native86
	#Check if there are common icons
	comm -1 -2 $main/tmp/bk_native86 $main/tmp/sys_native86 > $main/tmp/cp_native86
	if [ -s "$main/tmp/cp_native86" ]; then
		# Restore native icons
		for file in $(<$main/tmp/cp_native86); do cp "$main/backup/native/86x86/apps/$file" $dir_native/86x86/apps; done
	fi
	# List backuped native icons 108x108
	ls $main/backup/native/108x108/apps > $main/tmp/bk_native108
	# List native icons
	ls $dir_native/108x108/apps > $main/tmp/sys_native108
	#Check if there are common icons
	comm -1 -2 $main/tmp/bk_native108 $main/tmp/sys_native108 > $main/tmp/cp_native108
	if [ -s "$main/tmp/cp_native108" ]; then
		# Restore native icons
		for file in $(<$main/backup/cp_native108); do rm "$dir_native/108x108/apps/$file"; done
		for file in $(<$main/tmp/cp_native108); do cp "$main/backup/native/108x108/apps/$file" $dir_native/108x108/apps; done
	fi
	# List backuped native icons 128x128
	ls $main/backup/native/128x128/apps > $main/tmp/bk_native128
	# List native icons
	ls $dir_native/128x128/apps > $main/tmp/sys_native128
	#Check if there are common icons
	comm -1 -2 $main/tmp/bk_native128 $main/tmp/sys_native128 > $main/tmp/cp_native128
	if [ -s "$main/tmp/cp_native128" ]; then
		# Restore native icons
		for file in $(<$main/backup/cp_native128); do rm "$dir_native/128x128/apps/$file"; done
		for file in $(<$main/tmp/cp_native128); do cp "$main/backup/native/128x128/apps/$file" $dir_native/128x128/apps; done
	fi
	# List backuped native icons 256x256
	ls $main/backup/native/256x256/apps > $main/tmp/bk_native256
	# List native icons
	ls $dir_native/256x256/apps > $main/tmp/sys_native256
	#Check if there are common icons
	comm -1 -2 $main/tmp/bk_native256 $main/tmp/sys_native256 > $main/tmp/cp_native256
	if [ -s "$main/tmp/cp_native256" ]; then
		# Restore native icons
		for file in $(<$main/backup/cp_native256); do rm "$dir_native/256x256/apps/$file"; done
		for file in $(<$main/tmp/cp_native256); do cp "$main/backup/native/256x256/apps/$file" $dir_native/256x256/apps; done
	fi
	# BACKUP THEME
	# List native icons 86x86
	cp $dir_native/86x86/apps/* $main/backup/native/86x86/apps/
	# List native icons 108x108
	cp $dir_native/108x108/apps/* $main/backup/native/108x108/apps/
	# List native icons 128x128
	cp $dir_native/128x128/apps/* $main/backup/native/128x128/apps/
	# List native icons 256x256
	cp $dir_native/256x256/apps/* $main/backup/native/256x256/apps/
	# APPLY THEME
	if [ -d "$pack/native/86x86/apps" ] && [ "$(ls $pack/native/86x86/apps)" ]; then
		# List icon pack icons
		ls $pack/native/86x86/apps > $main/tmp/pack_native86
		# List native icons
		ls $dir_native/86x86/apps > $main/tmp/sys_native86
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_native86 $main/tmp/sys_native86 > $main/backup/cp_native86
		if [ -s "$main/backup/cp_native86" ]; then
			# Copy selected native icon pack
			for file in $(<$main/backup/cp_native86); do cp "$pack/native/86x86/apps/$file" $dir_native/86x86/apps; done
		fi
	fi
	if [ -d "$pack/native/108x108/apps" ] && [ "$(ls $pack/native/108x108/apps)" ]; then
		# List icon pack icons
		ls $pack/native/108x108/apps > $main/tmp/pack_native108
		# List native icons
		ls $dir_native/108x108/apps > $main/tmp/sys_native108
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_native108 $main/tmp/sys_native108 > $main/backup/cp_native108
		if [ -s "$main/backup/cp_native108" ]; then
			# Copy selected native icon pack
			for file in $(<$main/backup/cp_native108); do cp "$pack/native/108x108/apps/$file" $dir_native/108x108/apps; done
		fi
	fi
	if [ -d "$pack/native/128x128/apps" ] && [ "$(ls $pack/native/128x128/apps)" ]; then
		# List icon pack icons
		ls $pack/native/128x128/apps > $main/tmp/pack_native128
		# List native icons
		ls $dir_native/128x128/apps > $main/tmp/sys_native128
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_native128 $main/tmp/sys_native128 > $main/backup/cp_native128
		if [ -s "$main/backup/cp_native128" ]; then
			# Copy selected native icon pack
			for file in $(<$main/backup/cp_native128); do cp "$pack/native/128x128/apps/$file" $dir_native/128x128/apps; done
		fi
	fi
	if [ -d "$pack/native/256x256/apps" ] && [ "$(ls $pack/native/256x256/apps)" ]; then
		# List icon pack icons
		ls $pack/native/256x256/apps > $main/tmp/pack_native256
		# List native icons
		ls $dir_native/256x256/apps > $main/tmp/sys_native256
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_native256 $main/tmp/sys_native256 > $main/backup/cp_native256
		if [ -s "$main/backup/cp_native256" ]; then
			# Copy selected native icon pack
			for file in $(<$main/backup/cp_native256); do cp "$pack/native/256x256/apps/$file" $dir_native/256x256/apps; done
		fi
	fi
fi

# If Android support is installed
if [ -d "$dir_apk" ] && [[ "$sizea" != "$(<$main/size_droid)" ]]; then
	echo $sizea > $main/size_droid
	#RESTORE THEME
	# List backuped Android icons
	ls $main/backup/apk/ > $main/tmp/bk_apk
	# List Android icons
	ls $dir_apk > $main/tmp/sys_apk
	#Check if there are common icons
	comm -1 -2 $main/tmp/bk_apk $main/tmp/sys_apk > $main/tmp/cp_apk
	if [ -s "$main/tmp/cp_apk" ]; then
		# Restore Android icons
		for file in $(<$main/tmp/cp_apk); do cp "$main/backup/apk/$file" $dir_apk; done
	fi
	# BACKUP THEME
	cp $dir_apk/* $main/backup/apk/
	# APPLY THEME
	# Check if there are Android icons
	if [ -d "$pack/apk/128x128" ] && [ "$(ls $pack/apk/128x128)" ]; then
		# List icon pack icons
		ls $pack/apk/128x128 > $main/tmp/pack_apk
		# List Android icons
		ls $dir_apk > $main/tmp/sys_apk
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_apk $main/tmp/sys_apk > $main/tmp/cp_apk
		if [ -s "$main/tmp/cp_apk" ]; then
			# Copy selected Android icon pack
			for file in $(<$main/tmp/cp_apk); do cp "$pack/apk/128x128/$file" $dir_apk; done
		fi
	elif [ -d "$pack/apk/86x86" ] && [ "$(ls $pack/apk/86x86)" ]; then
		# List icon pack icons
		ls $pack/apk/86x86 > $main/tmp/pack_apk
		# List Android icons
		ls $dir_apk > $main/tmp/sys_apk
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_apk $main/tmp/sys_apk > $main/tmp/cp_apk
		if [ -s "$main/tmp/cp_apk" ]; then
			# Copy selected Android icon pack
			for file in $(<$main/tmp/cp_apk); do cp "$pack/apk/86x86/$file" $dir_apk; done
		fi
	fi
fi
