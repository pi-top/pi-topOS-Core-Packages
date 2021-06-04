#!/bin/bash
export TEXTDOMAIN=pt-eeprom

# shellcheck disable=SC1091
. gettext.sh

zenity --password --title "$(gettext "Password Required")"
