local zim_install=${test_dir}/${0:t:r}

# download the repository
command curl -sS --proto -all,+https https://raw.githubusercontent.com/zimfw/install/develop/install.zsh | ZDOTDIR=${zim_install} zsh >/dev/null

command sed -i.bak -E 's/( +.*) zsh-autosuggestions/\1/' ${zim_install}/.zimrc

# start interactive-login shell
ZDOTDIR=${zim_install} zsh -ilc 'wait; exit' >/dev/null
