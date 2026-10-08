#!/usr/bin/env fish

function link
  ln -vsfFn $argv
end

link $PWD/gitattributes $HOME/.gitattributes
link $PWD/gitignore $HOME/.gitignore
link $PWD/gitconfig $HOME/.gitconfig

link $PWD/psqlrc $HOME/.psqlrc

link $PWD/ptconfig.toml $HOME/.ptconfig.toml

link $PWD/tmux.conf $HOME/.tmux.conf

link $PWD/fish $HOME/.config

link $PWD/nvim $HOME/.config

brew bundle --no-upgrade --file=$PWD/Brewfile

set plug $HOME/.local/share/nvim/site/autoload/plug.vim
if not test -f $plug
  curl -fLo $plug --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
end
nvim --headless +PlugInstall +qall
