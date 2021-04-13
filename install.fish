#!/usr/bin/env fish

function link
  ln -vsfFn $argv
end

link $PWD/gitattributes $HOME/.gitattributes
link $PWD/gitignore $HOME/.gitignore
link $PWD/gitconfig $HOME/.gitconfig
link $PWD/githelpers $HOME/.githelpers

link $PWD/psqlrc $HOME/.psqlrc

link $PWD/ptconfig.toml $HOME/.ptconfig.toml

link $PWD/tmux.conf $HOME/.tmux.conf

link $PWD/fish $HOME/.config

link $PWD/nvim $HOME/.config
