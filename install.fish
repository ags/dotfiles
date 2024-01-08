#!/usr/bin/env fish

function link
  ln -vsfFn $argv
end

link $PWD/asdfrc $HOME/.asdfrc
