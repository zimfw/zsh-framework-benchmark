() {
local -r home_dir=${1}

# just touch .zshrc
touch ${home_dir}/.zshrc
} "${@}"
