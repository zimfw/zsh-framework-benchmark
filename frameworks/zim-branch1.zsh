() {
local -r home_dir=${1}

# download the repository
command curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | HOME=${home_dir} zsh

command sleep 1
# add modules to .zshrc
>! ${home_dir}/.zimrc <<\END
zmodule environment
zmodule git
zmodule input
zmodule termtitle
zmodule utility

zmodule duration-info
zmodule git-info
zmodule asciiship

zmodule zsh-users/zsh-completions --fpath src
zmodule completion --branch generate-dat-file

zmodule zsh-users/zsh-syntax-highlighting
zmodule zsh-users/zsh-history-substring-search
zmodule zsh-users/zsh-autosuggestions
END

HOME=${home_dir} zsh -ic 'zimfw update'
} "${@}"
