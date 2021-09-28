() {
local -r home_dir=${1}

# download the repository
command curl -sS --proto -all,+https https://raw.githubusercontent.com/zimfw/install/master/install.zsh | HOME=${home_dir} zsh

# start login shell
HOME=${home_dir} zsh -lc 'wait; exit'
# command cp ${home_dir}/.zshrc{,.orig}
# print '
# unset CHARSET LANG LC_COLLATE
# ' >! ${home_dir}/.zshrc
# cat ${home_dir}/.zshrc.orig >>! ${home_dir}/.zshrc
# print '
# print sourced zshrc >>! ~/../calls.txt
# ' >>! ${home_dir}/.zshrc
# command rm -rf ${home_dir}/.zshrc.orig
# HOME=${home_dir} zsh -lc 'exit'
# ZDOTDIR=${home_dir} HOME=${home_dir} ZIM_HOME=${home_dir}/.zim zsh -c "source ${home_dir}/../../trace-zim && mv /tmp/ztrace.tar.gz ${home_dir}/.."
} "${@}"
