# Determine arguments for ls colours
if [[ -x "`whence -p dircolors`" ]]; then
  alias ls='ls --color=auto'
else
  alias ls='ls -G'
fi

alias v='nvim'

alias be='bundle exec'

alias g='git'
alias ga='git add -p'
alias gc='git commit -v'
alias gd='git fetch && git rebase origin/$(current_branch)'
alias gp='git push origin $(current_branch)'
alias grd='git rebase -i origin/develop'
alias grm='git rebase -i origin/master'
alias gs='git status -sb'
alias gfrd='git fetch && git rebase -i origin/develop'
