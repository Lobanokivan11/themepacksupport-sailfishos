Name:          harbour-themepacksupport
Version:       0.0.8
Release:       7
Summary:       Theme pack support
Obsoletes:     harbour-iconpacksupport <= 0.0.4-4
Conflicts:     harbour-iconpacksupport
Group:         System/Tools
Vendor:        fravaccaro
Distribution:  SailfishOS
Packager: fravaccaro <fravaccaro@jollacommunity.it>
URL:           www.jollacommunity.it
License:       GPL

%description
Theme pack support for Sailfish OS.

%files
%defattr(-,root,root,-)
/usr/share/*

%post
chmod +x /usr/share/harbour-themepacksupport/*.sh
ln -s /usr/share/harbour-themepacksupport/themepacksupport.sh /usr/bin/themepacksupport
mv /usr/share/harbour-themepacksupport/harbour-themepacksupport.png /usr/share/icons/hicolor/86x86/apps/
mv /usr/share/harbour-themepacksupport/harbour-themepacksupport.desktop /usr/share/applications/

%preun
/usr/share/harbour-themepacksupport/icon-restore.sh
/usr/share/harbour-themepacksupport/font-restore.sh
/usr/share/harbour-themepacksupport/sound-restore.sh

%postun
if [ $1 = 0 ]; then
    // Do stuff specific to uninstalls
unlink /usr/bin/themepacksupport
rm /usr/share/icons/hicolor/86x86/apps/harbour-themepacksupport.png
rm /usr/share/applications/harbour-themepacksupport.desktop
rm -rf /usr/share/harbour-themepacksupport
else
if [ $1 = 1 ]; then
    // Do stuff specific to upgrades
echo "Upgrading"
fi
fi

%changelog
* Tue Jan 12 2016 0.0.8
- Different resolutions support.
- Uninstall theme packs via UI.
- Added Alien Dalvik font resizer.

* Sun Jan 10 2016 0.0.7
- Non-latin fonts theming support.
- Added option to choose font weight.

* Fri Jan 8 2016 0.0.6
- Non-latin fonts kept.

* Wed Dec 30 2015 0.0.4
- Added Jolla Ambient support.

* Mon Dec 28 2015 0.0.3
- Bug fix.

* Mon Dec 28 2015 0.0.2
- Help and info pages added.
- Bug fix.

* Sun Dec 27 2015 0.0.1
- First build.
