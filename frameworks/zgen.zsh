# clone the repository
command git clone --quiet https://github.com/tarjoilija/zgen.git .zgen

# add modules to .zshrc
>>! .zshrc <<\END
ZGEN_AUTOLOAD_COMPINIT=0

# zgen does not add functions subdirs to fpath, nor autoloads them!
setopt EXTENDED_GLOB
fpath+=(~/.zgen/zimfw/*/functions(NF))
autoload -Uz -- ~/.zgen/zimfw/*/functions/^(*~|*.zwc(|.old)|_*|prompt_*_setup)(N-.:t)

source ~/.zgen/zgen.zsh
if ! zgen saved; then
  zgen load zimfw/environment
  zgen load zimfw/git
  zgen load zimfw/input
  zgen load zimfw/termtitle
  zgen load zimfw/utility
  zgen load zimfw/duration-info
  zgen load zimfw/git-info
  zgen load zimfw/asciiship asciiship
  zgen load zsh-users/zsh-completions
  zgen load zimfw/completion
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search
  zgen save
fi
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
END
