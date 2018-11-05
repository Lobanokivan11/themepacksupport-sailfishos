#!/bin/bash
# Set directory variables
backup=/usr/share/harbour-themepacksupport/backup/dlocks
system=/etc/dconf/db/vendor.d/locks/

if [ -f $backup/silica-configs.txt.bk ]; then
	mv $backup/silica-configs.txt.bk $system/silica-configs.txt
fi

if [ -f $backup/ui-configs.txt.bk ]; then
	mv $backup/ui-configs.txt.bk $system/ui-configs.txt
fi

su - nemo -c "dconf update"

exit 0
