() {
local -r home_dir=${1}

# download the repository
command git clone --quiet https://github.com/zplug/zplug ${home_dir}/.zplug

# add modules to .zshrc
print 'source ${HOME}/.zplug/init.zsh
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
' >>! ${home_dir}/.zshrc

# install the plugins
HOME=${home_dir} zsh -ic 'zplug install; exit'
} "${@}"
