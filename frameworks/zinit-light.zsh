() {
local -r home_dir=${1}

# download the repository
command mkdir ${home_dir}/.zinit
command git clone --quiet https://github.com/zdharma-continuum/zinit.git ${home_dir}/.zinit/bin

# add modules to .zshrc
>>! ${home_dir}/.zshrc <<\END
PS1="%~%# "
source ~/.zinit/bin/zinit.zsh
zinit light "zimfw/environment"
zinit ice autoload"git-alias-lookup;git-branch-current;git-branch-delete-interactive;git-branch-remote-tracking;git-dir;git-ignore-add;git-root;git-stash-clear-interactive;git-stash-recover;git-submodule-move;git-submodule-remove"
zinit light "zimfw/git"
zinit light "zimfw/input"
zinit light "zimfw/termtitle"
zinit ice autoload"mkcd;mkpw"
zinit light "zimfw/utility"
zinit ice autoload"duration-info-precmd;duration-info-preexec"
zinit light "zimfw/duration-info"
zinit ice autoload"coalesce;git-action;git-info" nocompile
zinit light "zimfw/git-info"
zinit light "zimfw/asciiship"
zinit ice as"completion"
zinit light "zsh-users/zsh-completions"
zinit light "zsh-users/zsh-autosuggestions"
zinit light "zsh-users/zsh-syntax-highlighting"
zinit light "zsh-users/zsh-history-substring-search"

autoload -Uz compinit
compinit

zinit cdreplay -q

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
END

# compile the plugins
HOME=${home_dir} zsh -ic 'zinit compile --all; exit'
} "${@}"
