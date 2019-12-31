() {
local zgen_install=${1}

# download the repository
command git clone --quiet https://github.com/tarjoilija/zgen.git ${zgen_install}/.zgen

# add modules to .zshrc

# NOTE: we don't want ${HOME} to expand here; it will expand in the .zshrc
print 'HOME=${ZDOTDIR}
ZGEN_AUTOLOAD_COMPINIT=0
source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then
  zgen load zimfw/environment
  zgen load zimfw/git
  zgen load zimfw/input
  zgen load zimfw/termtitle
  zgen load zimfw/utility
  zgen load zimfw/git-info
  zgen load zimfw/steeef
  zgen load zsh-users/zsh-completions src
  zgen load zimfw/completion
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zimfw/history-substring-search
  zgen save
fi
' >>! ${zgen_install}/.zshrc
} "${@}"
