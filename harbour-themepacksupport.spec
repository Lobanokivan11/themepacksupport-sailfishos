Name:           harbour-themepacksupport
Version:        0.8.7
Release:        4
Summary:        Theme pack support
Obsoletes:      harbour-iconpacksupport <= 0.0.4-4
Conflicts:      harbour-iconpacksupport
Group:          System/Tools
Vendor:         fravaccaro
Distribution:   SailfishOS
Requires:       sailfish-version >= 2.1.4, rsync
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
chmod +x /usr/share/%{name}/*.sh
chmod +x /usr/share/%{name}/service/*.sh
mkdir -p /usr/share/%{name}/backup
mkdir -p /usr/share/%{name}/tmp
mv /usr/share/%{name}/service/themepacksupport-systemupgrade.service /lib/systemd/system/
mv /usr/share/%{name}/service/themepacksupport-autoupdate.service /etc/systemd/system/
mv /usr/share/%{name}/service/themepacksupport-autoupdate.timer /etc/systemd/system/
systemctl daemon-reload
systemctl enable themepacksupport-systemupgrade.service
// If UI Themer is installed, keep the icon hidden
if [ -d /usr/share/sailfishos-uithemer ]; then
	echo "NoDisplay=true" >> /usr/share/applications/%{name}.desktop
fi
if [ $1 = 1 ]; then
	// First installation
	ln -s /usr/share/%{name}/themepacksupport.sh /usr/bin/themepacksupport
	mv /usr/share/%{name}/%{name}.png /usr/share/icons/hicolor/86x86/apps/
	mv /usr/share/%{name}/%{name}.desktop /usr/share/applications/
fi

%preun
if [ $1 = 0 ]; then
	// Uninstallation
	/usr/share/%{name}/disable-autoupdate.sh
	/usr/share/%{name}/icon-restore.sh
	/usr/share/%{name}/graphic-restore.sh
	/usr/share/%{name}/font-restore.sh
	/usr/share/%{name}/sound-restore.sh
	/usr/share/%{name}/restore_dpr.sh
	/usr/share/%{name}/restore_adpi.sh
	/usr/share/%{name}/restore_iz.sh
	/usr/share/%{name}/disable-dpi.sh
fi

%postun
if [ $1 = 0 ]; then
	// Uninstallation
	unlink /usr/bin/themepacksupport
	rm /lib/systemd/system/themepacksupport-systemupgrade.service
	rm /etc/systemd/system/themepacksupport-autoupdate.timer
	rm /etc/systemd/system/themepacksupport-autoupdate.service
	rm /usr/share/icons/hicolor/86x86/apps/%{name}.png
	rm /usr/share/applications/%{name}.desktop
	rm -rf /usr/share/%{name}
fi

%changelog
* Mon Feb 18 2019 0.8.7
- Initial support for Android DPI settings on XA2.

* Sun Feb 10 2019 0.8.6
- Backup/restore icons.

* Thu Feb 7 2019 0.8.5
- Support for 192x192 Android icons.
- Overlay support improved for Sailfish X.
 
* Sat Jan 5 2019 0.8.4
- Service for running one-click restore before system upgrades.

* Wed Dec 19 2018 0.8.3
- Redesigned icon menu.

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
