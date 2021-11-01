# pi-topOS Core Packages

This repository consists of a Debian source package that builds multiple binary packages. These packages simplify the organisation and structure of packages in pi-topOS.

It is used as a convenient way of installing all of the component parts required for pi-topOS, and smoothly handling changes in packages during system updates.

Simple systemd services are managed via the `pt-os-notify-services` package. More advanced services are provided as part of separate source packages.

`pt-os` is the root Debian package. Installing this package will install ALL packages that pi-topOS uses on top of Raspberry Pi OS.

Required dependencies:
* `pt-os-sys-mods` (Provides a package-updatable method for providing OTA updates/fixes)
* `pt-os-version` (Used to identify pi-topOS version)

`neofetch` is a recommended dependency for SSH login message in the OS build.

The remaining dependencies are dummy packages for installing the various parts of the OS:
* `pt-device-support`
* `pt-os-apps`
* `pt-os-desktop`
* `pt-os-dev-tools`
* `pt-os-networking`
* `pt-os-onboarding`
* `pt-os-ui`
* `pt-os-user-libs`

See [`debian/control`](debian/control) for more detail about what packages are installed.

## `pt-os-apps`
Adds `/usr/bin/sonic-pi-server` for starting Sonic Pi without frontend GUI.

## `pt-os-init`

Adds first-time init logic:

### `/usr/sbin/pt-os-first-boot-setup`

Handles modifying `/boot/cmdline.txt` for handling first time boot.
During first boot:
* prevent pi-top [4] from showing 'connect SD card' animation
* expand file system
* enable wifi card
* disable text redirect

Additional files:
* `/usr/lib/pt-os-init/pt-hub-handshake`
* `/usr/lib/pt-os-init/source`

## `pt-os-notify-services`
Simple utilities used by pi-topOS, provided by systemd services. This package contains a background memory usage monitor, a service to notify users when they are using a preview build of pi-topOS and a service to ensure that Raspberry Pi 4s that are in use with a pi-top [4] have their EEPROM configured correctly.

Services:
* `pt-os-memory-monitor`
* `pt-wifi-ap-warning`
* `pt-eeprom-manager`
* `pt-os-version-notify`

## `pt-os-version`
A simple text file containing the OS version: `/etc/pi-top_os_version`.
