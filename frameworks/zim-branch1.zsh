() {
local -r home_dir=${1}

# download the repository
command curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | HOME=${home_dir} zsh

command sleep 1
command curl -fsSL -o ${home_dir}/.zim/zimfw.zsh https://raw.githubusercontent.com/zimfw/zimfw/use-home-in-init-zsh/zimfw.zsh
HOME=${home_dir} zsh -ic 'zimfw build'
} "${@}"
