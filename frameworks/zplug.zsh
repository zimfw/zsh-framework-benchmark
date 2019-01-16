local zplug_install=${test_dir}/${0:t:r}

# download the repository
command git clone --quiet https://github.com/zplug/zplug ${zplug_install}/.zplug

# add modules to .zshrc

# NOTE: we don't want ${HOME} to expand here; it will expand in the .zshrc
print 'HOME=${ZDOTDIR}
source ${HOME}/.zplug/init.zsh
zplug "zimfw/directory"
zplug "zimfw/environment"
zplug "zimfw/git"
zplug "zimfw/git-info"
zplug "zimfw/history"
zplug "zimfw/input"
zplug "zimfw/utility"
zplug "zimfw/prompt"
zplug "zsh-users/zsh-completions"
zplug "zimfw/completion"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:2
zplug load
if zplug check zsh-users/zsh-history-substring-search; then
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down
fi
' >>! ${zplug_install}/.zshrc

# install the plugins
ZDOTDIR=${zplug_install} zsh -ic 'zplug install; exit' >/dev/null
