# pi-topOS Core Packages

This repository consists of a Debian source package that builds multiple binary packages. These packages simplify the organisation and structure of packages in pi-topOS.

It is used as a convenient way of installing all of the component parts required for pi-topOS, and smoothly handling changes in packages during system updates.

Simple systemd services are managed via the `pt-os-notify-services` package. More advanced services are provided as part of separate source packages.
