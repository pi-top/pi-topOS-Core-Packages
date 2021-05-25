#!./Bash-Automated-Testing-System/bats-core/bin/bats

GIT_ROOT="$(git rev-parse --show-toplevel)"

load 'Bash-Automated-Testing-System/bats-support/load'
load 'Bash-Automated-Testing-System/bats-assert/load'

who() {
    [ $# = 0 ] || return
    echo "pi       tty1         2020-05-18 11:51
pi       tty7         2020-05-18 11:51 (:0)
pi       pts/0        2020-05-19 08:19 (192.168.1.199)
pi       pts/1        2020-05-19 08:58 (192.168.1.199)"
}
export -f who

pgrep() {
    [ $1 = "-a" ] || return
    [ $2 = "Xorg" ] || return
    echo "834 /usr/lib/xorg/Xorg :0 -seat seat0 -auth /var/run/lightdm/root/:0 -nolisten tcp vt7 -novtswitch"
}
export -f pgrep

@test "get_display finds the correct display number" {
    source "${GIT_ROOT}/src/pt-notify-send"
    assert_equal "$(get_display)" ":0"
}

@test "get_user_using_display finds user when display exists" {
    source "${GIT_ROOT}/src/pt-notify-send"
    local display=$(get_display)
    assert_equal "$(get_user_using_display "${display}")" "pi"
}

@test "get_user_using_display returns empty is display is not found" {
    source "${GIT_ROOT}/src/pt-notify-send"
    assert_equal "$(get_user_using_display ::1)" ""
}

@test "send_notification receives arguments correctly" {
    source "${GIT_ROOT}/src/pt-notify-send"

    function send_notification() {
        [ $1 = "pi" ] || echo "1st argument not 'pi'"
        [ $2 = ":0" ] || echo "2nd argument not ':0'"
        [ $3 = "message" ] || echo "3rd argument not 'message'"
        echo "Message sent"
    }
    export -f send_notification

    assert_equal "$(run_main message)" "Message sent"
}
