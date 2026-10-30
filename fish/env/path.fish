# Homebrew keeps libpq out of PATH. On Linux, apt's libpq-dev is already
# where compilers look.
if test -d /opt/homebrew/opt/libpq
  fish_add_path /opt/homebrew/opt/libpq/bin

  set -gx LDFLAGS "-L/opt/homebrew/opt/libpq/lib"
  set -gx CPPFLAGS "-I/opt/homebrew/opt/libpq/include"
end
