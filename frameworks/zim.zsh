() {
local -r home_dir=${1}

# download the repository
command curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | HOME=${home_dir} zsh
} "${@}"
