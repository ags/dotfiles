# Terminals such as iTerm2 set LANG, but apps that start fish themselves
# may not. Rails apps like tc refuse to boot without a UTF-8 locale.
if not set -q LANG
  set -gx LANG en_US.UTF-8
end
