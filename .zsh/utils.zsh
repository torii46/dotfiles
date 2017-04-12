has() {
    type "${1:?too few arguments}" &>/dev/null
}

# is_login_shell returns true if current shell is first shell
is_login_shell() {
    [[ $SHLVL == 1 ]]
}

# is_screen_running returns true if GNU screen is running
is_screen_running() {
    [[ -n $STY ]]
}

# is_tmux_running returns true if tmux is running
is_tmux_running() {
    [[ -n $TMUX ]]
}

# is_ssh_running returns true if ssh daemon is available
is_ssh_running() {
    [[ -n $SSH_CLIENT ]]
}

# ostype returns the lowercase OS name
ostype(){
    uname | tr "[:upper:]" "[:lower:]"
}

# os_detect export the PLATFORM variable
os_detect() {
    case "$(ostype)" in
        *'linux'*)   PLATFORM='linux'   ;;
        *'darwin'*)  PLATFORM='darwin'  ;;
        *'bsd'*)     PLATFORM='bsd'     ;;
        *)           PLATFORM='unknown' ;;
    esac
    export PLATFORM
}

# is_osx returns true if running OS is Mac
is_osx() {
    os_detect
    if [[ $PLATFORM == "osx" ]]; then
        return 0
    else
        return 1
    fi
}

# is_linux returns true if running OS is Linux
is_linux() {
    os_detect
    if [[ $PLATFORM == "linux" ]]; then
        return 0
    else
        return 1
    fi
}

# is_bsd returns true if running OS is BSD
is_bsd () {
    os_detect
    if [[ $PLATFORM == "bsd" ]]; then
        return 0
    else
        return 1
    fi
}

# echo_os echo OS name of running OS
echo_os() {
    local os
    for os in osx linux bsd; do
        if is_$os; then
            echo $os
        fi
    done
}
