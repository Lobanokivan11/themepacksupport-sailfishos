#!/bin/bash

# Set directory variables
backup=/usr/share/harbour-themepacksupport/backup
system=/etc/dconf/db/vendor.d

if [ -f $backup/vendord/silica-configs.txt.bk ]; then
	mv $backup/vendord/silica-configs.txt.bk $system/silica-configs.txt
fi

if [ -f $backup/dlocks/silica-configs.txt.bk ]; then
	mv $backup/dlocks/silica-configs.txt.bk $system/locks/silica-configs.txt
fi

if [ -f $backup/dlocks/ui-configs.txt.bk ]; then
	mv $backup/dlocks/ui-configs.txt.bk $system/locks/ui-configs.txt
fi

dconf update

exit 0
