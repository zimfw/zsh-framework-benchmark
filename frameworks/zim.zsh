() {
local -r home_dir=${1}

# download the repository
command curl -sS --proto -all,+https https://raw.githubusercontent.com/zimfw/install/master/install.zsh | HOME=${home_dir} zsh

# start login shell
HOME=${home_dir} zsh -lc 'wait; exit'
} "${@}"
