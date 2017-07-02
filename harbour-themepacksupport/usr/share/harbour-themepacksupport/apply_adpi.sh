#!/bin/bash

aliensize=$1

# Set directory variables
main=/usr/share/harbour-themepacksupport


# Check if default Android DPI backup exists
if [ ! -f $main/backup/droiddpi ]; then
   # Look for DPI settings and save them in a backup file
   grep "^ro.sf.lcd_density" /opt/alien/system/build.prop | tr ":" " " | egrep -o '.{1,3}$' > $main/backup/droiddpi
fi

# Apply Android DPI
sed -i "s/.*ro.sf.lcd_density.*/ro.sf.lcd_density=$aliensize/" /opt/alien/system/build.prop
grep "^ro.sf.lcd_density" /opt/alien/system/build.prop | tr ":" " " | egrep -o '.{1,3}$' > $main/droiddpi-current

exit 0
