() {
local -r home_dir=${1}

# download the repository
command mkdir ${home_dir}/.zinit
command git clone --quiet https://github.com/zdharma/zinit.git ${home_dir}/.zinit/bin

# add modules to .zshrc
print 'source ${HOME}/.zinit/bin/zinit.zsh
zinit wait lucid for "zimfw/environment"
zinit wait lucid autoload"git-alias-lookup;git-branch-current;git-branch-delete-interactive;git-dir;git-ignore-add;git-root;git-stash-clear-interactive;git-stash-recover;git-submodule-move;git-submodule-remove" for "zimfw/git"
zinit wait lucid for "zimfw/input"
zinit wait lucid for "zimfw/termtitle"
zinit wait lucid autoload"mkcd;mkpw" for "zimfw/utility"
zinit wait lucid autoload"duration-info-precmd;duration-info-preexec" for "zimfw/duration-info"
zinit wait lucid autoload"coalesce;git-action;git-info" for "zimfw/git-info"
zinit wait lucid for "zimfw/asciiship"
zinit wait lucid as"completion" for "zsh-users/zsh-completions"
zinit wait"0a" lucid for "zsh-users/zsh-autosuggestions"
zinit wait"0b" lucid for "zsh-users/zsh-syntax-highlighting"
zinit wait"0c" lucid atload"zicompinit;zicdreplay;bindkey \\"^[[A\\" history-substring-search-up;bindkey \\"^[[B\\" history-substring-search-down" for "zsh-users/zsh-history-substring-search"
' >>! ${home_dir}/.zshrc

# compile the plugins
HOME=${home_dir} zsh -ic 'zinit compile --all; exit'
} "${@}"
