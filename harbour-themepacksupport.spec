Name:           harbour-themepacksupport
Version:        0.8.2
Release:        1
Summary:        Theme pack support
Obsoletes:      harbour-iconpacksupport <= 0.0.4-4
Conflicts:       harbour-iconpacksupport
Group:          System/Tools
Vendor:         fravaccaro
Distribution:   SailfishOS
Requires:       sailfish-version >= 2.0.1, rsync
BuildArch:      noarch
Packager:       fravaccaro <fravaccaro@jollacommunity.it>
License:        GPLv3
URL:            https://github.com/fravaccaro/themepacksupport-sailfishos

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
// If UI Themer is installed, keep the icon hidden
if [ -d /usr/share/sailfishos-uithemer ]; then
	    echo "NoDisplay=true" >> /usr/share/applications/harbour-themepacksupport.desktop
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
	systemctl stop harbour-themepacksupport.timer
	systemctl disable harbour-themepacksupport.timer
	systemctl stop harbour-themepacksupport.service
	systemctl disable harbour-themepacksupport.service
	rm /etc/systemd/system/harbour-themepacksupport.timer
	rm /etc/systemd/system/harbour-themepacksupport.service
	/usr/share/harbour-themepacksupport/restore_dpr.sh
	/usr/share/harbour-themepacksupport/restore_iz.sh
	/usr/share/harbour-themepacksupport/restore_adpi.sh
	/usr/share/harbour-themepacksupport/preun_dpr.sh
	/usr/share/harbour-themepacksupport/icon-restore.sh
	/usr/share/harbour-themepacksupport/graphic-restore.sh
	/usr/share/harbour-themepacksupport/font-restore.sh
	/usr/share/harbour-themepacksupport/sound-restore.sh
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
* Fri Nov 23 2018 0.8.0
- Improved non latin font support.
- Overlay support.

* Tue Nov 13 2018 0.7.3
- Option to install dependencies.

* Mon Nov 5 2018 0.7.2
- Minor changes.

* Thu Oct 25 2018 0.7.1
- Added icon size.

* Sat Oct 20 2018 0.7.0
- Speed improvements.

* Tue Oct 16 2018 0.6.1
- Script now uses rsync.

* Wed Oct 3 2018 0.6.0
- Script reworked.

* Wed Feb 21 2018 0.5.6
- Preliminary icon size for Sailfish X (needs further testing).
- One-click restore.

* Mon Feb 19 2018 0.5.5
- Preliminary device pixel ratio support for Sailfish X (needs further testing).

* Sat Oct 21 2017 0.5.4
- Android DPI fix on Sailfish X.

* Fri Oct 20 2017 0.5.3
- Bug fixes.

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
