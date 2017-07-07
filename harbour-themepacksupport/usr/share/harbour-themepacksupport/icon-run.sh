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

# Check if a backup has been performed
if [ "$(ls $main/backup/jolla)" -o "$(ls $main/backup/native)" -o "$(ls $main/backup/apk)" -o "$(ls $main/backup/dyncal)" -o "$(ls $main/backup/dynclock)" ]; then

# Check if there are Jolla icons
if [ -d "$pack/jolla" ]; then

# Check if there are Jolla icons z1.0
	if [ "$(ls $pack/jolla/z1.0/icons)" ]; then
		# List icon pack icons
		ls $pack/jolla/z1.0/icons > $main/tmp/pack_jolla1
		# List Jolla icons
		ls $dir_jolla/z1.0/icons > $main/tmp/sys_jolla1
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_jolla1 $main/tmp/sys_jolla1 > $main/tmp/cp_jolla1
		if [ -s "$main/tmp/cp_jolla1" ]; then
			# Copy selected Jolla icon pack
			for file in $(<$main/tmp/cp_jolla1); do cp "$pack/jolla/z1.0/icons/$file" $dir_jolla/z1.0/icons; done
		fi
	fi

# Check if there are Jolla icons z1.5
if [ -d "$dir_jolla/z1.5" ]; then
if [ -d "$pack/jolla/z1.5/icons" ]; then
	if [ "$(ls $pack/jolla/z1.5/icons)" ]; then
		# List icon pack icons
		ls $pack/jolla/z1.5/icons > $main/tmp/pack_jolla15
		# List Jolla icons
		ls $dir_jolla/z1.5/icons > $main/tmp/sys_jolla15
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_jolla15 $main/tmp/sys_jolla15 > $main/tmp/cp_jolla15
		if [ -s "$main/tmp/cp_jolla15" ]; then
			# Copy selected Jolla icon pack
			for file in $(<$main/tmp/cp_jolla15); do cp "$pack/jolla/z1.5/icons/$file" $dir_jolla/z1.5/icons; done
		fi
	fi
fi
fi

# Check if there are Jolla icons z1.25
if [ -d "$dir_jolla/z1.25" ]; then
if [ -d "$pack/jolla/z1.0/icons" ]; then
	if [ "$(ls $pack/jolla/z1.0/icons)" ]; then
		# List icon pack icons
		ls $pack/jolla/z1.0/icons > $main/tmp/pack_jolla125
		# List Jolla icons
		ls $dir_jolla/z1.25/icons > $main/tmp/sys_jolla125
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_jolla125 $main/tmp/sys_jolla125 > $main/tmp/cp_jolla125
		if [ -s "$main/tmp/cp_jolla125" ]; then
			# Copy selected Jolla icon pack
			for file in $(<$main/tmp/cp_jolla125); do cp "$pack/jolla/z1.0/icons/$file" $dir_jolla/z1.25/icons; done
		fi
	fi
fi
fi

# Check if there are Jolla icons z1.5-large
if [ -d "$dir_jolla/z1.5-large" ]; then
if [ -d "$pack/jolla/z1.5/icons" ]; then
	if [ "$(ls $pack/jolla/z1.5/icons)" ]; then
		# List icon pack icons
		ls $pack/jolla/z1.5/icons > $main/tmp/pack_jolla15l
		# List Jolla icons
		ls $dir_jolla/z1.5-large/icons > $main/tmp/sys_jolla15l
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_jolla15l $main/tmp/sys_jolla15l > $main/tmp/cp_jolla15l
		if [ -s "$main/tmp/cp_jolla15l" ]; then
			# Copy selected Jolla icon pack
			for file in $(<$main/tmp/cp_jolla15l); do cp "$pack/jolla/z1.5/icons/$file" $dir_jolla/z1.5-large/icons; done
		fi
	fi
fi
fi
# Check if there are Jolla icons z2.0
if [ -d "$dir_jolla/z2.0" ]; then
if [ -d "$pack/jolla/z2.0/icons" ]; then
	if [ "$(ls $pack/jolla/z2.0/icons)" ]; then
		# List icon pack icons
		ls $pack/jolla/z2.0/icons > $main/tmp/pack_jolla2
		# List Jolla icons
		ls $dir_jolla/z2.0/icons > $main/tmp/sys_jolla2
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_jolla2 $main/tmp/sys_jolla2 > $main/tmp/cp_jolla2
		if [ -s "$main/tmp/cp_jolla2" ]; then
			# Copy selected Jolla icon pack
			for file in $(<$main/tmp/cp_jolla2); do cp "$pack/jolla/z2.0/icons/$file" $dir_jolla/z2.0/icons; done
		fi
	fi
fi
fi

fi

# Check if there are native icons
if [ -d "$pack/native" ]; then

if [ -d "$pack/native/86x86/apps" ]; then
	if [ "$(ls $pack/native/86x86/apps)" ]; then
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
fi

if [ -d "$pack/native/108x108/apps" ]; then
	if [ "$(ls $pack/native/108x108/apps)" ]; then
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
fi

if [ -d "$pack/native/128x128/apps" ]; then
	if [ "$(ls $pack/native/128x128/apps)" ]; then
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
fi

if [ -d "$pack/native/256x256/apps" ]; then
	if [ "$(ls $pack/native/256x256/apps)" ]; then
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

fi

# If Android support is installed
if [ -d "$dir_apk" ]; then
	# Check if there are Android icons
	if [ -d "$pack/apk/128x128" ]; then
		if [ "$(ls $pack/apk/128x128)" ]; then
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
		fi
	else
		if [ -d "$pack/apk/86x86" ]; then
			if [ "$(ls $pack/apk/86x86)" ]; then
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
	fi
fi

# If DynCal is installed
if [ -d "/usr/share/harbour-dyncal" ]; then
	# Check if there are DynCal icons
	if [ -d "$pack/dyncal" ]; then
#		if [ -d "$pack/dyncal/256x256" ]; then
#			if [ "$(ls $pack/dyncal/256x256)" ]; then
#				rm -rf /usr/share/harbour-dyncal/icons/*
#				cp $pack/dyncal/256x256/*.* /usr/share/harbour-dyncal/icons/
#			fi
#		else
			if [ -d "$pack/dyncal/86x86" ]; then
				if [ "$(ls $pack/dyncal/86x86)" ]; then
					rm -rf /usr/share/harbour-dyncal/icons/*
					cp $pack/dyncal/86x86/*.* /usr/share/harbour-dyncal/icons/
					sh /usr/share/harbour-dyncal/harbour-dyncal.sh
				fi
			fi
#		fi
	fi
fi

# If DynClock is installed
if [ -d "/usr/share/harbour-dynclock" ]; then
	# Check if there are DynClock icons
	if [ -d "$pack/dynclock" ]; then
		# Check if the DynClock version installed supports hd icons
#		if [ -s "/usr/share/harbour-dynclock/dynclock.cfg" ]; then
#			if [ -d "$pack/dynclock/256x256" ]; then
#				if [ "$(ls $pack/dynclock/256x256)" ]; then
#					cp $pack/dynclock/256x256/*.* /usr/share/harbour-dynclock/
#				else
#				if [ -d "$pack/dynclock/86x86" ]; then
#					if [ "$(ls $pack/dynclock/86x86)" ]; then
#						cp $pack/dynclock/86x86/*.* /usr/share/harbour-dynclock/
#						echo res="43" > /usr/share/harbour-dynclock/dynclock.cfg
#					fi
#				fi
#			fi
#		fi
#		else
			if [ -d "$pack/dynclock/86x86" ]; then
				if [ "$(ls $pack/dynclock/86x86)" ]; then
					cp $pack/dynclock/86x86/*.* /usr/share/harbour-dynclock/
					echo res="43" > /usr/share/harbour-dynclock/dynclock.cfg
					sh /usr/share/harbour-dynclock/harbour-dynclock.sh
				fi
			fi
#		fi
	fi
fi

# Clean tmp directory
if [ "$(ls $main/tmp)" ]; then
	rm $main/tmp/*
fi

# Save current icon pack
rm $main/icon-current
echo $iconpack > $main/icon-current

# Re-enable service if enabled
if [[ "$(sed -n 2p $main/themepacksupport.cfg)" =~ "1" ]]; then
	systemctl enable harbour-themepacksupport.timer
	systemctl start harbour-themepacksupport.timer
	systemctl enable harbour-themepacksupport.service
	systemctl start harbour-themepacksupport.service
fi

# Warm about backup not performed
else
echo "Run backup first!"

fi

exit 0
