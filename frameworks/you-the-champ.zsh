(

emulate -L zsh -o err_return -o no_unset -o no_aliases
cd -- $1

# Install you-the-champ.zsh.
curl -fsSLO https://raw.githubusercontent.com/romkatv/you-the-champ/master/you-the-champ.zsh

# Create .zshrc.
>.zshrc <<\END
source ~/you-the-champ.zsh || return 0

# Use zcomet to initialize zsh.
# Could use anything else: you-the-champ works with everything.
if [[ ! -e ~/.zcomet/bin ]]; then
  git clone https://github.com/agkozak/zcomet.git ~/.zcomet/bin
fi

source ~/.zcomet/bin/zcomet.zsh
zcomet load zimfw/environment
zcomet load zimfw/git
zcomet load zimfw/input
zcomet load zimfw/termtitle
zcomet load zimfw/utility
zcomet load zimfw/duration-info
zcomet load zimfw/git-info
zcomet load zimfw/asciiship
zcomet fpath zsh-users/zsh-completions src
zcomet load zsh-users/zsh-autosuggestions
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-history-substring-search

[[ ${TERM} != dumb ]] && zcomet compinit

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
END

# Install everything.
HOME=$PWD zsh -is <<<'exit 0'

)
