# Loads a project's .envrc, such as tc's, when you cd into it.
if status is-interactive; and command -q direnv
  direnv hook fish | source
end
