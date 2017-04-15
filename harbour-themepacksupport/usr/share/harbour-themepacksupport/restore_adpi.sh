#!/bin/bash

# Set directory variables
main=/usr/share/harbour-themepacksupport

# Check if default Android DPI backup exists
if [ -f $main/backup/droiddpi ]; then
	# Restore Android DPI
	sed -i "s/.*ro.sf.lcd_density.*/ro.sf.lcd_density=$(<$main/backup/droiddpi)/" /opt/alien/system/build.prop
fi
