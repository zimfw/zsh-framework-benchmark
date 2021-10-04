() {
local -r home_dir=${1}

# install antibody
[[ ! -e ${home_dir}/bin/antibody ]] && command curl -sL git.io/antibody | sh -s - -b ${home_dir}/bin

>>! ${home_dir}/.zsh_plugins.txt <<\END
zimfw/environment
zimfw/git
zimfw/input
zimfw/termtitle
zimfw/utility
zimfw/duration-info
zimfw/git-info
zimfw/asciiship
zsh-users/zsh-completions
zimfw/completion
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
END

HOME=${home_dir} ${home_dir}/bin/antibody bundle < ${home_dir}/.zsh_plugins.txt > ${home_dir}/.zsh_plugins.sh

>>! ${home_dir}/.zshrc <<\END
# antibody does not add functions subdirs to fpath, nor autoloads them!
setopt EXTENDED_GLOB
fpath+=($(~/bin/antibody home)/*zimfw*/functions(NF))
autoload -Uz -- $(~/bin/antibody home)/*zimfw*/functions/^(*~|*.zwc(|.old)|_*|prompt_*_setup)(N-.:t)

source ~/.zsh_plugins.sh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
END
} "${@}"
