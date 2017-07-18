Name:          harbour-themepacksupport
Version:       0.5.2
Release:       2
Summary:       Theme pack support
Obsoletes:     harbour-iconpacksupport <= 0.0.4-4
Conflicts:     harbour-iconpacksupport
Group:         System/Tools
Vendor:        fravaccaro
Distribution:  SailfishOS
Requires:      sailfish-version >= 2.0.1, sailfish-content-graphics-default-z1.0-base
BuildArch:     noarch
Packager:      fravaccaro <fravaccaro@jollacommunity.it>
URL:           www.jollacommunity.it
License:       GPLv3

%description
Theme pack support for Sailfish OS.

%files
%defattr(-,root,root,-)
/usr/share/*

%post
chmod +x /usr/share/harbour-themepacksupport/*.sh
/usr/share/harbour-themepacksupport/postin_dpr.sh
if [ ! -f /etc/systemd/system/harbour-themepacksupport.* ]; then
	mv /usr/share/harbour-themepacksupport/service/harbour-themepacksupport.service /etc/systemd/system/
	mv /usr/share/harbour-themepacksupport/service/harbour-themepacksupport.timer /etc/systemd/system/
fi
if [ $1 = 1 ]; then
	// First installation
	ln -s /usr/share/harbour-themepacksupport/themepacksupport.sh /usr/bin/themepacksupport
	mv /usr/share/harbour-themepacksupport/harbour-themepacksupport.png /usr/share/icons/hicolor/86x86/apps/
	mv /usr/share/harbour-themepacksupport/harbour-themepacksupport.desktop /usr/share/applications/
	mv /usr/share/harbour-themepacksupport/service/harbour-themepacksupport.service /etc/systemd/system/
	mv /usr/share/harbour-themepacksupport/service/harbour-themepacksupport.timer /etc/systemd/system/
fi

%preun
if [ $1 = 0 ]; then
	// Uninstallation
	/usr/share/harbour-themepacksupport/preun_dpr.sh
	/usr/share/harbour-themepacksupport/restore_dpr.sh
	/usr/share/harbour-themepacksupport/restore_adpi.sh
	/usr/share/harbour-themepacksupport/icon-restore.sh
	/usr/share/harbour-themepacksupport/graphic-restore.sh
	/usr/share/harbour-themepacksupport/font-restore.sh
	/usr/share/harbour-themepacksupport/sound-restore.sh
	systemctl stop harbour-themepacksupport.timer
	systemctl disable harbour-themepacksupport.timer
	systemctl stop harbour-themepacksupport.service
	systemctl disable harbour-themepacksupport.service
	rm /etc/systemd/system/harbour-themepacksupport.timer
	rm /etc/systemd/system/harbour-themepacksupport.service
fi

%postun
if [ $1 = 0 ]; then
	// Uninstallation
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
* Sat Jul 15 2017 0.5.2
- More Icon updater options.

* Fri Jul 7 2017 0.5.1
- Minor fixes.

* Sat Jul 1 2017 0.5.0
- Added auto-update icons option.

* Thu Jun 29 2017 0.4.0
- Added icon restore option.
- Bug fix.

* Sat Apr 15 2017 0.3.3
- Compatibility with UI themer.

* Sat Apr 15 2017 0.3.2
- Compatibility with UI themer.

* Fri Mar 31 2017 0.3.1
- Bug fix.
- Fixed non latin fonts missing from Alien Dalvik.

* Fri Mar 10 2017 0.3.0
- Fixed font size option.
- Added Patchmanager restore options.
- Added UI themer options.

* Thu Jan 5 2017 0.2.1
- Bug fix.

* Thu Aug 25 2016 0.2.0
- Added graphic theme support.

* Tue Aug 9 2016 0.1.3
- Added Jolla C/Intex Aqua Fish support.

* Wed Apr 27 2016 0.1.1
- Added Jolla Tablet support.
- Bug fix

* Tue Jan 19 2016 0.1.0
- Sailfish OS 2.0.7 support.

* Tue Jan 19 2016 0.0.9
- DynClock high resolution support added.

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
