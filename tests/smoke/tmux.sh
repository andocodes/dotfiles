#!/bin/sh
set -eu

for path in \
  home/dot_tmux.conf.tmpl \
  home/dot_config/tmux/tmux.conf \
  home/dot_config/tmux/plugins.conf \
  home/dot_config/tmuxp/default.yaml
do
  [ -f "$path" ] || {
    echo "missing $path" >&2
    exit 1
  }
done

test_home="$PWD/.tmp/tmux-home"
rm -rf "$test_home"
mkdir -p "$test_home/.config"
ln -s "$PWD/home/dot_config/tmux" "$test_home/.config/tmux"

HOME="$test_home" tmux -L dotfiles-test -f "$PWD/home/dot_config/tmux/tmux.conf" start-server
HOME="$test_home" tmux -L dotfiles-test kill-server >/dev/null 2>&1 || true
