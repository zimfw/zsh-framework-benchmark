() {
local -r home_dir=${1}

# download the repository
command git clone --quiet https://github.com/tarjoilija/zgen.git ${home_dir}/.zgen

# add modules to .zshrc
print 'ZGEN_AUTOLOAD_COMPINIT=0
# zgen does not add functions subdirs to fpath, nor autoloads them!
() {
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  local zdir zfunction
  for zdir in ${HOME}/.zgen/zimfw/*(NF); do
    fpath+=(${zdir}/functions(NF))
    for zfunction in ${zdir}/functions/^(*~|*.zwc(|.old)|_*|prompt_*_setup)(N-.:t); do
      autoload -Uz ${zfunction}
    done
  done
}
source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then
  zgen load zimfw/environment
  zgen load zimfw/git
  zgen load zimfw/input
  zgen load zimfw/termtitle
  zgen load zimfw/utility
  zgen load zimfw/git-info
  zgen load zimfw/steeef steeef
  zgen load zsh-users/zsh-completions src
  zgen load zimfw/completion
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search
  zgen save
fi
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
' >>! ${home_dir}/.zshrc
} "${@}"
