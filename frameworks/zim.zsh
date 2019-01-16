() {
local zim_install=${1}

# download the repository
command git clone --quiet --recursive https://github.com/zimfw/zimfw.git "${zim_install}/.zim"

# follow the install instructions
local template_file user_file
for template_file in ${zim_install}/.zim/templates/*; do
  user_file="${zim_install}/.${template_file:t}"
  command cat ${template_file} ${user_file}(.N) > ${user_file}.tmp && command mv ${user_file}{.tmp,}
done

# no need to enable any extra modules; this is our baseline.

# start interactive-login shell
ZDOTDIR=${zim_install} zsh -ilc 'wait; exit' >/dev/null
} "${@}"
