set fish_greeting ""

for f in $HOME/.config/fish/env/*
	source $f
end

abbr g git
abbr k kubectl
abbr v nvim
abbr be 'bundle exec'

alias cdr "cd (git rev-parse --show-toplevel)"

alias ga   "git add -p"
alias gc   "git commit -v"
alias gfrm "git fetch && git rebase -i origin/HEAD"
alias gp   "git push"
alias grm  "git rebase -i origin/HEAD"
alias gs   "git st"

# macOS ships a BSD ctags in /usr/bin, so use Homebrew's universal-ctags.
if test -x /opt/homebrew/bin/ctags
  alias retag "/opt/homebrew/bin/ctags -R --exclude=.git --exclude=log --exclude=tmp --exclude=node_modules"
else
  alias retag "ctags -R --exclude=.git --exclude=log --exclude=tmp --exclude=node_modules"
end

fish_add_path $HOME/.local/bin
