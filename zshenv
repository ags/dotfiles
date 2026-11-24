# fish is the login shell. Tools that run commands through zsh, such as
# Claude Code's Bash tool, start a non-interactive shell that reads only
# this file. mise's shims pick each tool's version from the directory a
# command runs in, so they work without the prompt hook that `mise
# activate` relies on.
if command -v mise >/dev/null; then
  eval "$(mise activate zsh --shims)"
fi

# By default zsh swaps a word such as `=ls` for the path of `ls`, so an
# unquoted `=====` argument fails with "not found".
setopt noequals

# Terminals such as iTerm2 set LANG, but apps that start zsh themselves,
# such as Claude Code, may not. Rails apps like tc refuse to boot without
# a UTF-8 locale.
export LANG=${LANG:-en_US.UTF-8}

# Homebrew keeps libpq out of PATH, and tc's Makefile calls psql and
# createdb. fish/env/path.fish does the same for fish.
if [ -d /opt/homebrew/opt/libpq/bin ]; then
  export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
fi

# Settings for one machine, such as OP_ACCOUNT when 1Password has more
# than one account signed in, live outside this public repo.
if [ -f "$HOME/.zshenv.local" ]; then
  . "$HOME/.zshenv.local"
fi
