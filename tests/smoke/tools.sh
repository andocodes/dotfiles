#!/bin/sh
set -eu

for path in \
  home/dot_config/nvim/init.lua \
  home/dot_config/nvim/lua/config/lazy.lua \
  home/dot_config/yazi/yazi.toml \
  home/dot_config/lazygit/config.yml \
  home/dot_config/lazydocker/config.yml \
  home/dot_config/ghostty/config
do
  [ -f "$path" ] || {
    echo "missing $path" >&2
    exit 1
  }
done
