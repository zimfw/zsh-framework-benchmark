local omz_install=${test_dir}/${0:t:r}

# download the install script
command curl -sS -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh >${omz_install}/install.sh
# also remove the automatic-start of the new terminal
# silence the git clone output
command sed -i.bak -e '/env zsh -l/d' -e 's/git clone/git clone --quiet/g' ${omz_install}/install.sh

# run though sh as per the instructions
HOME=${omz_install} ZSH=${omz_install}/.oh-my-zsh sh ${omz_install}/install.sh >/dev/null

# grab zsh-syntax-highlighting
command git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git ${omz_install}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# we don't need auto-update stuff
# replace the plugin string with the selected plugins
command sed -i.bak -E -e 's/^# (DISABLE_AUTO_UPDATE="true")/\1/' -e 's/^( *git)/\1 git-prompt zsh-syntax-highlighting history-substring-search/' ${omz_install}/.zshrc
