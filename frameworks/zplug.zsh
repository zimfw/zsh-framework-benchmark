# clone the repository
command git clone --quiet https://github.com/zplug/zplug .zplug

# add modules to .zshrc
>>! .zshrc <<\END
source ~/.zplug/init.zsh
zplug "zimfw/environment"
zplug "zimfw/git"
zplug "zimfw/input"
zplug "zimfw/termtitle"
zplug "zimfw/utility"
zplug "zimfw/duration-info", lazy:yes
zplug "zimfw/git-info", lazy:yes
zplug "zimfw/asciiship", as:theme
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug load
if zplug check zsh-users/zsh-history-substring-search; then
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down
fi
END

# install the plugins
HOME=${PWD} zsh -ic 'zplug install; exit'
