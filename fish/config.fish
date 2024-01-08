set fish_greeting ""

for f in $HOME/.config/fish/env/*
	source $f
end

source /opt/homebrew/opt/asdf/libexec/asdf.fish

abbr g git
abbr k kubectl
abbr v nvim
abbr be 'bundle exec'

alias cdr "cd (git rev-parse --show-toplevel)"

alias ga   "git add -p"
alias gc   "git commit -v"
alias gfrm "git fetch && git rebase -i origin/main"
alias gp   "git push"
alias grm  "git rebase -i origin/main"
alias gs   "git st"
alias gpr "gh pr create -d && gh pr view -w"

alias retag "ctags -R --exclude=.git --exclude=log --exclude=tmp --exclude=node_modules"

if [ -f '/Users/ags/Code/google-cloud-sdk/path.fish.inc' ]; . '/Users/ags/Code/google-cloud-sdk/path.fish.inc'; end
