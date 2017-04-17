Informations on how create theme packs compatible with my script.

## Requisites

* A basic knowledge on how to compile rpm's. [This guide](http://talk.maemo.org/showthread.php?t=92963) 
was useful to me (it works on Linux computers too).

## Icons, fonts, sounds

Read the page relative to the theme part you're creating, then come back here.

* [Icons](docs/icons)
* [Fonts](docs/fonts.md)
* [Sounds](docs/sounds)

## .spec file

Open the .spec file and edit these lines:
* **Name**: the name used in the system to identify your package.
* **Version**: the version of the package.
* **Release**: the issue of the version.
* **Summary**: an intellegible name for your package.
* **Vendor**: your name/nickname.
* **Packager**: your name/nickname and email (optional).
* **URL**: your blog/website (optional).
* **description**: description for your package.
* **changelog**: the changelog of your package.

### Notes

* The name of the package must start with *harbour-themepack-* e.g. *harbour-themepack-mypackage*.
* The file *package* contains the intelligible name of your icon pack e.g. *My theme pack*. Keep it on 
one line.

## Building and releasing

You are ready to build the package and publish it! The preferred method is on 
[openrepos.net](https://openrepos.net). Don't forget to add as a notice to enable [my 
repository](https://openrepos.net/user/583/repository) and have at least Theme pack support 0.0.5 
installed, otherwise it won't work!
