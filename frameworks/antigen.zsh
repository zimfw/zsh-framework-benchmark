() {
local -r home_dir=${1}

# download the repository
command curl -Ss -L git.io/antigen > ${home_dir}/antigen.zsh

# add modules to .zshrc
print 'source ${HOME}/antigen.zsh
antigen bundle zimfw/environment
antigen bundle zimfw/git
antigen bundle zimfw/input
antigen bundle zimfw/termtitle
antigen bundle zimfw/utility
antigen bundle zimfw/git-info
antigen theme zimfw/steeef
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
# antigen adds functions to fpath but does not autoload them!
() {
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  local zfunction
  for zfunction in ${HOME}/.antigen/bundles/zimfw/*/functions/^(*~|*.zwc(|.old)|_*|prompt_*_setup)(N-.:t); do
    autoload -Uz ${zfunction}
  done
}
antigen apply
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
' >>! ${home_dir}/.zshrc
} "${@}"
