# Homebrew keeps libpq out of PATH. On Linux, apt's libpq-dev is already
# where compilers look.
if test -d /opt/homebrew/opt/libpq
  fish_add_path /opt/homebrew/opt/libpq/bin

  set -gx LDFLAGS "-L/opt/homebrew/opt/libpq/lib"
  set -gx CPPFLAGS "-I/opt/homebrew/opt/libpq/include"
end

# The gcloud-cli cask links gcloud into Homebrew's bin, but not the
# components `gcloud components install` adds. kubectl runs one of them,
# gke-gcloud-auth-plugin, to log in to a GKE cluster.
#
# The SDK's bin goes at the end of PATH, so a kubectl that gcloud
# installs into it can't shadow Homebrew's. --path appends to PATH
# itself. Without it, the entry goes in fish_user_paths, which fish puts
# ahead of Homebrew's bin, and which persists after the cask is gone.
if test -d /opt/homebrew/share/google-cloud-sdk/bin
  fish_add_path --path --append /opt/homebrew/share/google-cloud-sdk/bin
end
