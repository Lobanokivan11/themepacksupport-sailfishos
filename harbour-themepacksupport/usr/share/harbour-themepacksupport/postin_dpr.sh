#!/bin/bash
# Set directory variables
backup=/usr/share/harbour-themepacksupport/backup/dlocks
system=/etc/dconf/db/vendor.d/locks/

if [ -f $system/silica-configs.txt ]; then
	mv $system/silica-configs.txt $backup/silica-configs.txt.bk
fi

if [ -f $system/ui-configs.txt ]; then
	mv $system/ui-configs.txt $backup/ui-configs.txt.bk
fi

dconf update

exit 0
