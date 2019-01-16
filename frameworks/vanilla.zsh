() {
local vanilla_install=${1}

# just touch .zshrc
touch ${vanilla_install}/.zshrc
} "${@}"
