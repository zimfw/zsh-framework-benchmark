() {
local -r home_dir=${1}

# download the repository
command git clone --quiet --recursive https://github.com/sorin-ionescu/prezto.git "${home_dir}/.zprezto"

# follow the install instructions
setopt LOCAL_OPTIONS EXTENDED_GLOB
local rcfile
for rcfile in "${home_dir}"/.zprezto/runcoms/^README.md(.N); do
  command ln -s "${rcfile}" "${home_dir}/.${rcfile:t}"
done

# add the modules to the .zpreztorc file
command rm -f ${home_dir}/.zpreztorc
command cp ${home_dir}/.zprezto/runcoms/zpreztorc ${home_dir}/.zpreztorc
command sed -i.bak -E -e "/^ *'spectrum' \\\\/d" -e "s/^( *'prompt')/\\1 'git' 'autosuggestions' 'syntax-highlighting' 'history-substring-search'/" ${home_dir}/.zpreztorc

# start login shell
HOME=${home_dir} zsh -lc 'wait; exit'
} "${@}"
