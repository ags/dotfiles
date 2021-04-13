set fish_greeting ""

for f in $HOME/.config/fish/env/*
	source $f
end

abbr g git
abbr v nvim
abbr be 'bundle exec'

alias cdr "cd (git rev-parse --show-toplevel)"

alias ga   "git add -p"
alias gc   "git commit -v"
alias gfrm "git fetch && git rebase -i origin/master"
alias gp   "git push"
alias grm  "git rebase -i origin/master"
alias gs   "git st"
