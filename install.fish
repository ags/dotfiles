#!/usr/bin/env fish

# BSD ln's -F replaces a directory at the target. GNU ln has no such flag,
# so on Linux a real directory at the target is moved aside first.
function link
  if test (uname) = Darwin
    ln -vsfFn $argv
  else
    ln -vsfn $argv
  end
end

# Links a directory into ~/.config. Fish creates ~/.config/fish the first
# time it starts, so on a new machine that directory can already exist.
function link_config
  set name (basename $argv[1])
  set target $HOME/.config/$name
  if test -d $target; and not test -L $target
    mv -v $target $target.bak
  end
  link $argv[1] $HOME/.config
end

mkdir -p $HOME/.config

link $PWD/gitattributes $HOME/.gitattributes
link $PWD/gitignore $HOME/.gitignore
link $PWD/gitconfig $HOME/.gitconfig

link $PWD/psqlrc $HOME/.psqlrc

link $PWD/tmux.conf $HOME/.tmux.conf

link_config $PWD/fish

link $PWD/zshenv $HOME/.zshenv

link_config $PWD/nvim

# On Linux, bootstrap-linux.sh installs the packages from apt.
if test (uname) = Darwin
  brew bundle --no-upgrade --file=$PWD/Brewfile
end

set plug $HOME/.local/share/nvim/site/autoload/plug.vim
if not test -f $plug
  curl -fLo $plug --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
end
nvim --headless +PlugInstall +qall
