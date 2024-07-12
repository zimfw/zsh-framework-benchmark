# install antibody
[[ ! -e bin/antibody ]] && command curl -sL git.io/antibody | sh -s - -b bin

>>! .zsh_plugins.txt <<\END
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

HOME=${PWD} ANTIBODY_HOME=${PWD}/.antibody bin/antibody bundle < .zsh_plugins.txt > .zsh_plugins.sh

>>! .zshrc <<\END
export ANTIBODY_HOME=~/.antibody

# antibody does not add functions subdirs to fpath, nor autoloads them!
setopt EXTENDED_GLOB
fpath+=(${ANTIBODY_HOME}/*zimfw*/functions(NF))
autoload -Uz -- ${ANTIBODY_HOME}/*zimfw*/functions/^(*~|*.zwc(|.old)|_*|prompt_*_setup)(N-.:t)

source ~/.zsh_plugins.sh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
END
