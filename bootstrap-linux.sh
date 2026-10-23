#!/usr/bin/env bash
# Sets up a new Ubuntu machine, such as a WSL distro, then runs
# install.fish. Run it from a clone of this repository:
#
#   ./bootstrap-linux.sh
#
# It asks for your password for sudo and for chsh. Running it again is
# safe, and skips what's already installed.
set -euo pipefail
cd "$(dirname "$0")"

# The apt names for most of the Brewfile. Homebrew's casks have no
# equivalent here, and kubectl, tfenv, gcloud and pup are left for when a
# project needs them.
sudo apt-get update
sudo apt-get install -y \
  build-essential curl fish fzf gh git jq libpq-dev neovim pv ripgrep \
  ruby tmux tree universal-ctags unzip zsh

mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

if ! command -v mise >/dev/null; then
  curl -fsSL https://mise.run | sh
fi
mise use --global node@lts

# The prose-lint hooks in ~/.claude call Vale, which apt doesn't package.
vale_version=3.25.1
if ! command -v vale >/dev/null; then
  case "$(uname -m)" in
    x86_64) vale_arch=64-bit ;;
    aarch64) vale_arch=arm64 ;;
  esac
  curl -fsSL "https://github.com/vale-cli/vale/releases/download/v${vale_version}/vale_${vale_version}_Linux_${vale_arch}.tar.gz" |
    tar -xz -C "$HOME/.local/bin" vale
fi

# Playwright tests that launch with channel: 'chrome' need Google Chrome,
# which Google only builds for x86_64 Linux.
if ! command -v google-chrome >/dev/null && [ "$(uname -m)" = x86_64 ]; then
  deb="$(mktemp -d)/google-chrome.deb"
  curl -fsSLo "$deb" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt-get install -y "$deb"
fi

if ! command -v claude >/dev/null; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

# gitconfig sends GitHub URLs over SSH. On WSL, Windows' ssh.exe can reach
# the 1Password SSH agent, so use it for git.
if grep -qi microsoft /proc/version && [ ! -f "$HOME/.gitconfig.local" ]; then
  git config --file "$HOME/.gitconfig.local" core.sshCommand ssh.exe
fi

if [ "$(getent passwd "$USER" | cut -d: -f7)" != /usr/bin/fish ]; then
  chsh -s /usr/bin/fish
fi

fish ./install.fish
