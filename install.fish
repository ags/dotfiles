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
  link $argv[1] $target
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

# iTerm2 loads each JSON file in DynamicProfiles as a profile, and reloads
# it when it changes. The Nord profile takes its colours from
# iterm2/Nord.itermcolors, a copy of nordtheme/iterm2's src/xml file, and
# everything else from the Default profile.
if test (uname) = Darwin
  set dynamic "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
  set nord_guid 6C1F3E2A-5B7D-4E8F-9A0B-1C2D3E4F5A6B
  mkdir -p $dynamic
  plutil -convert json -o - $PWD/iterm2/Nord.itermcolors \
    | jq --arg guid $nord_guid '{Profiles: [. + {
        Name: "Nord",
        Guid: $guid,
        "Dynamic Profile Parent Name": "Default"
      }]}' >$dynamic/Nord.json

  # iTerm2 writes its preferences back when it quits, which would undo a
  # change made while it runs.
  if pgrep -xq iTerm2
    echo "iTerm2 is running. Quit it and rerun this script to make Nord the default profile."
  else
    defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string $nord_guid
  end
end
