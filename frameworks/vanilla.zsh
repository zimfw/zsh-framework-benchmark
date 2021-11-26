() {
local -r home_dir=${1}

# just set PS1
>>! ${home_dir}/.zshrc <<\END
PS1="%~%# "
END
} "${@}"
