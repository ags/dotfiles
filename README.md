dotfiles
========

Assorted configuration files.

On macOS:

```
./install.fish
```

On Ubuntu, including a WSL distro, install the packages first. The script
then runs `install.fish` itself:

```
./bootstrap-linux.sh
```

`iterm2/Nord.itermcolors` comes from [nordtheme/iterm2](https://github.com/nordtheme/iterm2)
(MIT). `install.fish` turns it into an iTerm2 dynamic profile named Nord
and makes that the default profile.
