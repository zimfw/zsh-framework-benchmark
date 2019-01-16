() {
local prezto_install=${1}

# download the repository
command git clone --quiet --recursive https://github.com/sorin-ionescu/prezto.git "${prezto_install}/.zprezto"

# follow the install instructions
setopt LOCAL_OPTIONS EXTENDED_GLOB
local rcfile
for rcfile in "${prezto_install}"/.zprezto/runcoms/^README.md(.N); do
  command ln -s "${rcfile}" "${prezto_install}/.${rcfile:t}"
done

# add the modules to the .zpreztorc file
command rm -f ${prezto_install}/.zpreztorc
command cp ${prezto_install}/.zprezto/runcoms/zpreztorc ${prezto_install}/.zpreztorc
command sed -i.bak -E -e "/^ *'spectrum' \\\\/d" -e "s/^( *'prompt')/\\1 'syntax-highlighting' 'history-substring-search'/" ${prezto_install}/.zpreztorc

# start login shell
ZDOTDIR=${prezto_install} zsh -lc 'wait; exit' >/dev/null
} "${@}"
