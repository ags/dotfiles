# Homebrew's mise package ships a `vendor_conf.d` hook with this file
# name, which runs the full `mise activate fish`. That puts the install
# directories for the directory fish started in on `PATH`. Tools that
# copy fish's `PATH`, such as Claude Code's Bash tool, then run those
# versions in every repo.
#
# Fish runs only the first `conf.d` file with a given name, so this one
# replaces Homebrew's, and uses shims instead. Shims pick each tool's
# version from the directory a command runs in.
if command -q mise
    mise activate fish --shims | source
end
