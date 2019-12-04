() {
local antigen_install=${1}

# download the repository
command curl -Ss -L git.io/antigen > ${antigen_install}/antigen.zsh

# add modules to .zshrc

# NOTE: we don't want ${HOME} to expand here; it will expand in the .zshrc
print 'HOME=${ZDOTDIR}
source ${HOME}/antigen.zsh
antigen bundle zimfw/directory
antigen bundle zimfw/environment
antigen bundle zimfw/git
antigen bundle zimfw/git-info
antigen bundle zimfw/history
antigen bundle zimfw/input
antigen bundle zimfw/utility
antigen theme zimfw/steeef
antigen bundle zsh-users/zsh-completions
antigen bundle zimfw/completion
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
# antigen adds functions to fpath but does not autoload them!
() {
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  local zfunction
  for zfunction in ${HOME}/.antigen/bundles/zimfw/*/functions/^(_*|*.*|prompt_*_setup)(-.N:t); do
    autoload -Uz ${zfunction}
  done
}
antigen apply
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
' >>! ${antigen_install}/.zshrc
} "${@}"
