() {
local -r home_dir=${1}

# download the repository
command curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | HOME=${home_dir} zsh

command sleep 1
command rm -fv ${home_dir}/.zim/zimfw.zsh ${home_dir}/.zim/(login_|)init.zsh ${home_dir}/.*.zwc(|.old)(N)
command curl -fsSL https://raw.githubusercontent.com/zimfw/zimfw/deprecate_login_init/zimfw.zsh --output ${home_dir}/.zim/zimfw.zsh
command ls -la ${home_dir}

# start interactive shell
HOME=${home_dir} zsh -ic 'exit'
command ls -la ${home_dir}
} "${@}"
