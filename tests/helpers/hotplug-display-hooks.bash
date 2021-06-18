# shellcheck source=tests/helpers/global_variables.bash
source "tests/helpers/global_variables.bash"

FILE_TO_TEST="${GIT_ROOT}/src/hotplug_display.sh"
export FILE_TO_TEST

setup() {
	source "${FILE_TO_TEST}"

	load "helpers/mock_functions.bash"
	load "helpers/mock_variables.bash"
}
