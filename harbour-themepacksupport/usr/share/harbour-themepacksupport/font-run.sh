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

# Usage ./run.sh -f [fontpackname] -s [sfosfontweight] -a [androidfontweight] -d [androidfontlightweight]

# Set font pack name variable

while getopts ":f:s:a:d:" opt; do
  case "$opt" in
    f) fontpack=$OPTARG ;;
    s) sd=$OPTARG ;;
    a) ad=$OPTARG ;;
    d) al=$OPTARG ;;
  esac
done

# Is the font name variable empty?
if [ -z $fontpack ]; then
	exit 1
fi

# Set directory variables
main=/usr/share/harbour-themepacksupport
pack=/usr/share/harbour-themepack-$fontpack
dir_jolla=/usr/share/fonts
dir_apk=/opt/alien/system/fonts

# Check if a backup has been performed
if [ "$(ls $main/backup/font)" -o "$(ls $main/backup/font-droid)" -o "$(ls $main/backup/font-nonlatin)" ]; then

# Check if there are Jolla fonts
if [ -d "$pack/font" ]; then
# If variables are not empty
if [ ! -z "$sd" ]; then
	# Copy selected Jolla font pack
	cp $pack/font/$sd.ttf $dir_jolla/sail-sans-pro/SailSansPro-Light.ttf
	if [ -s "$pack/font/Regular.ttf" ]; then
		cp $pack/font/Regular.ttf $dir_jolla/droid/DroidSans.ttf
	fi
		if [ -s "$pack/font/Bold.ttf" ]; then
		cp $pack/font/Bold.ttf $dir_jolla/droid/DroidSansBold.ttf
	fi
	if [ -s "$pack/font/BoldItalic.ttf" ]; then
		cp $pack/font/BoldItalic.ttf $dir_jolla/droid/DroidSansBoldItalic.ttf
	fi
	if [ -s "$pack/font/Italic.ttf" ]; then
		cp $pack/font/Italic.ttf $dir_jolla/droid/DroidSansItalic.ttf
	fi
#	if [ -s "$pack/font/Mono.ttf" ]; then
#		cp $pack/font/Mono.ttf $dir_jolla/droid/DroidSansMono.ttf
#	fi
fi
fi

# If Android support is installed
if [ -d "$dir_apk" ]; then
	# Check if there are Android fonts
	if [ -d "$pack/font" ]; then
	# If variables are not empty
	if [ ! -z "$ad" -o ! -z "$al" ]; then
		# List fonts
		ls $dir_apk > $main/tmp/font-droid
		cd $pack/font; ls *.ttf > $main/font-droid
		# Keep Android emojis
		sed -i "/AndroidEmoji.ttf/d" $main/tmp/font-droid
		sed -i "/Droid*/d" $main/tmp/font-droid
		sed -i "/Noto*/d" $main/tmp/font-droid
		# Delete the other fonts
#		for file in $(<$main/tmp/font-droid); do rm -rf "$dir_apk/$file"; done
		# Copy selected Jolla font pack
		cp $pack/font/$ad.ttf $dir_apk/Roboto-Regular.ttf
		cp $pack/font/$al.ttf $dir_apk/Roboto-Light.ttf
		if [ -s "$pack/font/Bold.ttf" ]; then
			cp $pack/font/Bold.ttf $dir_apk/Roboto-Bold.ttf
		fi
		if [ -s "$pack/font/BoldItalic.ttf" ]; then
			cp $pack/font/BoldItalic.ttf $dir_apk/Roboto-BoldItalic.ttf
		fi
		if [ -s "$pack/font/Italic.ttf" ]; then
			cp $pack/font/Italic.ttf $dir_apk/Roboto-Italic.ttf
		fi
		if [ -s "$pack/font/LightItalic.ttf" ]; then
			cp $pack/font/LightItalic.ttf $dir_apk/Roboto-LightItalic.ttf
		fi
#		if [ -s "$pack/font/Mono.ttf" ]; then
#			cp $pack/font/Mono.ttf $dir_apk/DroidSansMono.ttf
#		fi
	fi
	fi
fi

if [ -d "$pack/font-nonlatin" ]; then
	# Copy selected non latin font pack
	if [ -s "$pack/font-nonlatin/Arabic.ttf" ]; then
		cp $pack/font-nonlatin/Arabic.ttf $dir_jolla/amiri/amiri-regular.ttf
		cp $pack/font-nonlatin/Arabic.ttf $dir_jolla/droid/DroidSansArabic.ttf
	fi
	if [ -s "$pack/font-nonlatin/Devanagari.ttf" ]; then
		cp $pack/font-nonlatin/Devanagari.ttf $dir_jolla/lohit-devanagari/Lohit-Devanagari.ttf
	fi
	if [ -s "$pack/font-nonlatin/Chinese.ttc" ]; then
		cp $pack/font-nonlatin/Chinese.ttc $dir_jolla/wqy-zenhei/wqy-zenhei.ttc
	fi
	if [ -s "$pack/font-nonlatin/Japanese.ttf" ]; then
		cp $pack/font-nonlatin/Japanese.ttf $dir_jolla/droid/DroidSansJapanese.ttf
	fi
	if [ -s "$pack/font-nonlatin/Hebrew.ttf" ]; then
		cp $pack/font-nonlatin/Hebrew.ttf $dir_jolla/droid/DroidSansHebrew.ttf
	fi
	if [ -s "$pack/font-nonlatin/Thai.ttf" ]; then
		cp $pack/font-nonlatin/Thai.ttf $dir_jolla/droid/DroidSansThai.ttf
	fi
	ls $pack/font-nonlatin > $main/tmp/font-other
	sed -i "/Arabic.ttf/d" $main/tmp/font-other
	sed -i "/Devanagari.ttf/d" $main/tmp/font-other
	sed -i "/Chinese.ttc/d" $main/tmp/font-other
	sed -i "/Japanese.ttf/d" $main/tmp/font-other
	sed -i "/Hebrew.ttf/d" $main/tmp/font-other
	sed -i "/Thai.ttf/d" $main/tmp/font-other
	if [ -s $main/tmp/font-other ]; then
		mkdir $dir_jolla/nonlatin
		for file in $(<$main/tmp/font-other)
		do cp "$pack/font-nonlatin/$file" $dir_jolla/nonlatin
		done
	fi

	# If Android support is installed
#	if [ -d "$dir_apk" ]; then
#		if [ -s "$pack/font-nonlatin/Armenian.ttf" ]; then
#			cp $pack/font-nonlatin/Armenian.ttf $dir_apk/DroidSansArmenian.ttf
#		fi
#		if [ -s "$pack/font-nonlatin/Devanagari.ttf" ]; then
#			cp $pack/font-nonlatin/Devanagari.ttf $dir_apk/DroidSansDevanagari-Regular.ttf
#		fi
#		if [ -s "$pack/font-nonlatin/Georgian.ttf" ]; then
#			cp $pack/font-nonlatin/Georgian.ttf $dir_apk/DroidSansGeorgian.ttf
#		fi
#		if [ -s "$pack/font-nonlatin/Ethiopic.ttf" ]; then
#			cp $pack/font-nonlatin/Ethiopic.ttf $dir_apk/DroidSansEthiopic-Regular.ttf
#		fi
#		if [ -s "$pack/font-nonlatin/Hebrew.ttf" ]; then
#			cp $pack/font-nonlatin/Hebrew.ttf $dir_apk/DroidSansHebrew-Regular.ttf
#		fi
#		if [ -s "$pack/font-nonlatin/Naskh.ttf" ]; then
#			cp $pack/font-nonlatin/Naskh.ttf $dir_apk/DroidNaskh-Regular.ttf
#		fi
#		if [ -s "$pack/font-nonlatin/Tamil.ttf" ]; then
#			cp $pack/font-nonlatin/Tamil.ttf $dir_apk/DroidSansTamil-Regular.ttf
#		fi
#		if [ -s "$pack/font-nonlatin/Thai.ttf" ]; then
#			cp $pack/font-nonlatin/Thai.ttf $dir_apk/DroidSansThai.ttf
#		fi
#	fi	
fi

# Clean tmp directory
if [ "$(ls $main/tmp)" ]; then
	rm $main/tmp/*
fi

# Save current font pack
rm $main/font-current
echo $fontpack > $main/font-current

# Warm about backup not performed
else
echo "Run backup first!"
fi
exit 0
