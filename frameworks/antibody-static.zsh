() {
local antibody_install=${1}

# install antibody
[[ ! -e ${antibody_install}/bin/antibody ]] && command curl -sL git.io/antibody | sh -s - -b ${antibody_install}/bin

print '
zimfw/environment
zimfw/git
zimfw/input
zimfw/termtitle
zimfw/utility
zimfw/git-info
zimfw/steeef
zsh-users/zsh-completions
zimfw/completion
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
' >>! ${antibody_install}/.zsh_plugins.txt

HOME=${antibody_install} ${antibody_install}/bin/antibody bundle < ${antibody_install}/.zsh_plugins.txt > ${antibody_install}/.zsh_plugins.sh

# NOTE: we don't want ${HOME} to expand here; it will expand in the .zshrc
print 'HOME=${ZDOTDIR}
# antibody does not add functions subdirs to fpath, nor autoloads them!
() {
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  local zdir zfunction
  for zdir in $(${HOME}/bin/antibody list | awk "{print \$2}"); do
    fpath+=(${zdir}/functions(NF))
    for zfunction in ${zdir}/functions/^(*~|*.zwc(|.old)|_*|prompt_*_setup)(N-.:t); do
      autoload -Uz ${zfunction}
    done
  done
}
source ${HOME}/.zsh_plugins.sh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
' >>! ${antibody_install}/.zshrc
} "${@}"
