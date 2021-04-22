() {
local -r home_dir=${1}

# install antibody
[[ ! -e ${home_dir}/bin/antibody ]] && command curl -sL git.io/antibody | sh -s - -b ${home_dir}/bin

print '
zimfw/environment
zimfw/git
zimfw/input
zimfw/termtitle
zimfw/utility
zimfw/duration-info
zimfw/git-info
zimfw/asciiship
zsh-users/zsh-completions
zimfw/completion
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
' >>! ${home_dir}/.zsh_plugins.txt

HOME=${home_dir} ${home_dir}/bin/antibody bundle < ${home_dir}/.zsh_plugins.txt > ${home_dir}/.zsh_plugins.sh

print '# antibody does not add functions subdirs to fpath, nor autoloads them!
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
' >>! ${home_dir}/.zshrc
} "${@}"
