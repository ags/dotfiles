set fish_greeting ""

for f in $HOME/.config/fish/env/*
	source $f
end

abbr g git
abbr v nvim
abbr be 'bundle exec'

alias ga   "git add -p"
alias gc   "git commit -v"
alias gfrd "git fetch && git rebase -i origin/develop"
alias gp   "git push"
alias grd  "git rebase -i origin/develop"
alias grm  "git rebase -i origin/master"
alias gs   "git st"
