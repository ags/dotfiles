# fish is the login shell. Tools that run commands through zsh, such as
# Claude Code's Bash tool, start a non-interactive shell that reads only
# this file. mise's shims pick each tool's version from the directory a
# command runs in, so they work without the prompt hook that `mise
# activate` relies on.
if command -v mise >/dev/null; then
  eval "$(mise activate zsh --shims)"
fi
