() {
local -r home_dir=${1}

# download the install script
command curl -sS -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh >${home_dir}/install.sh
# also remove the automatic-start of the new terminal
# silence the git clone output
command sed -i.bak -e '/env zsh -l/d' -e 's/git clone/git clone --quiet/g' ${home_dir}/install.sh

# run though sh as per the instructions
HOME=${home_dir} ZSH=${home_dir}/.oh-my-zsh sh ${home_dir}/install.sh --unattended

# grab zsh-syntax-highlighting
command git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ${home_dir}/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# grab zsh-syntax-highlighting
command git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git ${home_dir}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# we don't need auto-update stuff
# replace the plugin string with the selected plugins
command sed -i.bak -E -e 's/^# (DISABLE_AUTO_UPDATE="true")/\1/' -e 's/^(plugins=\([^\)]*)/\1 git-prompt colored-man-pages common-aliases timer zsh-autosuggestions zsh-syntax-highlighting history-substring-search/' ${home_dir}/.zshrc
} "${@}"
