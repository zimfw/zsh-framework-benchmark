(

emulate -L zsh -o err_return -o no_unset -o no_aliases
cd -- $1
# download zsh4humans v5
local v=5
curl -fsSLO https://github.com/romkatv/zsh4humans/archive/refs/heads/v${v}.tar.gz
# copy over .zshenv and .zshrc
tar -xzf v${v}.tar.gz
cp zsh4humans-${v}/{.zshenv,.zshrc} ./
# create a config for powerlevel10k
>.p10k.zsh <<<$'POWERLEVEL9K_MODE=ascii\nPOWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true'
# disable automatic start of tmux
sed -i.bak -E '1i\
zstyle :z4h: start-tmux no
' .zshrc
# install and load zimfw/git
sed -i.bak -E 's|^(z4h install [^|]*)|\1 zimfw/git|' .zshrc
sed -i.bak -E 's|^(z4h load [^|]*)|\1 $Z4H/zimfw/git|' .zshrc
rm -r v${v}.tar.gz zsh4humans-${v} .zshrc.bak
# don't ask to change shell
mkdir -p .cache/zsh4humans/v5/stickycache
touch .cache/zsh4humans/v5/stickycache/no-chsh
# initialize zsh4humans
HOME=${PWD} zsh -ic 'exit' </dev/null

)
