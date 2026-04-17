#!/bin/sh
set -eu

for path in \
  .chezmoiroot \
  home/.chezmoiignore.tmpl \
  home/.chezmoidata/features.yaml \
  home/.chezmoidata/machine.yaml \
  home/.chezmoidata/packages.yaml \
  home/.chezmoidata/runtimes.yaml
do
  [ -f "$path" ] || {
    echo "missing $path" >&2
    exit 1
  }
done

[ "$(cat .chezmoiroot)" = "home" ] || {
  echo ".chezmoiroot must equal home" >&2
  exit 1
}
