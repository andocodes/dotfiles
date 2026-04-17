#!/bin/sh
set -eu

for path in \
  home/dot_zshenv.tmpl \
  home/dot_config/zsh/dot_zshrc \
  home/dot_config/zsh/aliases.zsh \
  home/dot_config/starship.toml
do
  [ -f "$path" ] || {
    echo "missing $path" >&2
    exit 1
  }
done

zsh -n home/dot_zshenv.tmpl
zsh -n home/dot_config/zsh/dot_zshrc
zsh -n home/dot_config/zsh/aliases.zsh
