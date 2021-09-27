(

emulate -L zsh -o err_return -o no_unset -o no_aliases
cd -- $1
# download zsh4humans v5
local v=5
curl -fsSLO https://github.com/romkatv/zsh4humans/archive/refs/heads/v$v.tar.gz
# copy over .zshenv and .zshrc
tar -xzf v$v.tar.gz
cp zsh4humans-$v/{.zshenv,.zshrc} ./
# create a config for powerlevel10k
>.p10k.zsh <<<$'POWERLEVEL9K_MODE=ascii\nPOWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true'
# install and load zimfw/git
sed -i.bak -E 's|^(z4h install [^|]*)|\1 zimfw/git|' .zshrc
sed -i.bak -E 's|^(z4h load [^|]*)|\1 $Z4H/zimfw/git|' .zshrc
rm -r v$v.tar.gz zsh4humans-$v .zshrc.bak
# initialize zsh4humans; this will fail if the current process doesn't have a TTY
HOME=$PWD zsh -is <<<'exit'

)
