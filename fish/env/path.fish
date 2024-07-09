set -x GOPATH $HOME/Code/go

set -x PATH $PATH $GOPATH/bin

fish_add_path /opt/homebrew/opt/libpq/bin

set -gx LDFLAGS "-L/opt/homebrew/opt/libpq/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/libpq/include"
