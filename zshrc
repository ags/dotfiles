# Report the status of background jobs immediately, rather than waiting until
# just before printing a prompt.
setopt notify

# Parameter expansion, command substitution and arithmetic expansion are
# performed in prompts.
setopt prompt_subst

auto_sources=(`for f in ~/.zsh/*.zsh; do basename $f .zsh; done`)
for source in $auto_sources; do
  source ~/.zsh/$source.zsh
done
