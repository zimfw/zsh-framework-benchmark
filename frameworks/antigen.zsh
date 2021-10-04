() {
local -r home_dir=${1}

# download the repository
command curl -Ss -L git.io/antigen > ${home_dir}/antigen.zsh

# add modules to .zshrc
>>! ${home_dir}/.zshrc <<\END
source ~/antigen.zsh
antigen bundle zimfw/environment
antigen bundle zimfw/git
antigen bundle zimfw/input
antigen bundle zimfw/termtitle
antigen bundle zimfw/utility
antigen bundle zimfw/duration-info
antigen bundle zimfw/git-info
antigen theme zimfw/asciiship
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# antigen adds functions to fpath but does not autoload them!
setopt EXTENDED_GLOB
autoload -Uz -- ~/.antigen/bundles/zimfw/*/functions/^(*~|*.zwc(|.old)|_*|prompt_*_setup)(N-.:t)

antigen apply
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
END

# Force reinstall, as it was failing in alpine linux
HOME=${home_dir} zsh -ic 'antigen reset'
} "${@}"
