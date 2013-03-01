# colourful ls
alias ls='ls -G'

alias v='vim'

alias x='exit'

alias be='bundle exec'

alias vmtime='sudo /etc/init.d/networking restart && sudo /etc/init.d/ntp restart'

alias pdata='be rake db:reset db:production:data_light db:production:load_data db:migrate db:test:prepare'

alias pgen='openssl rand -hex'

# Git aliases
alias g='git'

alias gp='git push origin $(current_branch)'

alias gd='git fetch && git rebase origin/$(current_branch)'

alias ga='git add -p'

alias gc='git ci'

alias gs='git st -sb'

alias gdp='gd && gp'

alias gl='git log'
