() {
local zim_install=${1}

# download the repository
command curl -sS --proto -all,+https https://raw.githubusercontent.com/zimfw/install/master/install.zsh | ZDOTDIR=${zim_install} zsh >/dev/null

# start login shell
ZDOTDIR=${zim_install} zsh -lc 'wait; exit' >/dev/null
} "${@}"
