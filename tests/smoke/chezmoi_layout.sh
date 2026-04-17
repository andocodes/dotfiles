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

grep -q '\.machine\.defaults\.profile' home/.chezmoiignore.tmpl || {
  echo "home/.chezmoiignore.tmpl must read .machine.defaults.profile" >&2
  exit 1
}

grep -q '\.features\.defaults' home/.chezmoiignore.tmpl || {
  echo "home/.chezmoiignore.tmpl must read .features.defaults" >&2
  exit 1
}

grep -q 'if not \$profileDefaults' home/.chezmoiignore.tmpl || {
  echo "home/.chezmoiignore.tmpl must fall back when a profile override has no defaults" >&2
  exit 1
}
