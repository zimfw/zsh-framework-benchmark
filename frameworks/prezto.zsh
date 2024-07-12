# clone the repository
command git clone --quiet --recursive https://github.com/sorin-ionescu/prezto.git .zprezto

# follow the install instructions
setopt LOCAL_OPTIONS EXTENDED_GLOB
local rcfile
for rcfile in .zprezto/runcoms/^README.md(.N); do
  command ln -s "${rcfile}" ".${rcfile:t}"
done

# add the modules to the .zpreztorc file
command rm -f .zpreztorc
command cp .zprezto/runcoms/zpreztorc .zpreztorc
command sed -i.bak -E -e "/^ *'spectrum' \\\\/d" -e "s/^( *'prompt')/\\1 'git' 'autosuggestions' 'syntax-highlighting' 'history-substring-search'/" .zpreztorc

# start login shell
HOME=${PWD} zsh -lc 'exit'
