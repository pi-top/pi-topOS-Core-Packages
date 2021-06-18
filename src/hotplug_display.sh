#!/bin/bash
###############################################################
#                Unofficial 'Bash strict mode'                #
# http://redsymbol.net/articles/unofficial-bash-strict-mode/  #
###############################################################
set -euo pipefail
IFS=$'\n\t'
###############################################################

udev_breadcrumb="/tmp/pt-hotplug-display.breadcrumb"

wait_for_file_to_exist() {
	local path="${1}"

	# If file already exists, continue immediately
	[[ -f ${path} ]] && return

	local dir
	dir="$(dirname "${path}")"
	local file
	file="$(basename "${path}")"
	while read -r i; do if [ "$i" = "${file}" ]; then break; fi; done \
		< <(inotifywait -e create,open --format '%f' --quiet "${dir}" --monitor)
}

get_all_displays() {
	displays=$(ls "/tmp/.X11-unix/")
	echo "${displays}"
}

get_first_display() {
	first_display=$(get_all_displays | cut -d" " -f1 | sed "s/X//")
	echo "${first_display}"
}

update_resolution() {
	local display="${1}"
	env DISPLAY=:"$(get_first_display)" xrandr --output "${display}" --mode 1920x1080
}

unblank_display() {
	env DISPLAY=:"$(get_first_display)" xset dpms force on
}

handle_display_state() {
	# Touchscreen only compatible with pi-top [4]
	# Therefore, only compatible with Raspberry Pi 4
	#   pi-topOS default: 'vc4-fkms-v3d' driver
	#   pi-topOS default: 'hdmi_force_hotplug:1=1'
	#     ensured that HDMI1 (secondary) is 'first'
	#     for pi-top display cable - used for touchscreen!
	displays=('HDMI-1')

	# Update display state - may not be connected!
	for disp in "${displays[@]}"; do
		if env DISPLAY=:"$(get_first_display)" xrandr --query | grep -q "${disp} connected"; then
			update_resolution "${disp}"
			unblank_display
			break
		fi
	done
}

main() {
	while true; do
		wait_for_file_to_exist "${udev_breadcrumb}"
		rm "${udev_breadcrumb}"

		handle_display_state

	done
}

main
