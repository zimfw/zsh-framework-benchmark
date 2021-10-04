() {

local -r home_dir=${1}

git clone --recursive https://github.com/zpm-zsh/zpm ${home_dir}/.zpm

>! ${home_dir}/.zshrc <<\END
# zpm adds functions to fpath but does not autoload them!
setopt EXTENDED_GLOB
autoload -Uz -- ~/.zpm/plugins/zimfw--*/functions/^(*~|*.zwc(|.old)|_*|prompt_*_setup)(N-.:t)

source ~/.zpm/zpm.zsh

zpm load zimfw/environment
zpm load zimfw/git
zpm load zimfw/input
zpm load zimfw/termtitle
zpm load zimfw/utility
zpm load zimfw/duration-info
zpm load zimfw/git-info
zpm load zimfw/asciiship
zpm load zsh-users/zsh-completions,fpath:src
zpm load zsh-users/zsh-autosuggestions,source:zsh-autosuggestions.zsh
zpm load zsh-users/zsh-syntax-highlighting,source:zsh-syntax-highlighting.zsh
zpm load zsh-users/zsh-history-substring-search,source:zsh-history-substring-search.zsh

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
END

# Remove a cache directory that's kept outside of the user's home directory.
command rm -rf -- ${TMPDIR:-/tmp}/zsh-${UID:-user}

# Download and install plugins.
HOME=${home_dir} zsh -lic 'exit'

} "${@}"
