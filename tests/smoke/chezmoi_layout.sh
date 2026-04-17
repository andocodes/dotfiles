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

grep -q '\.defaults\.profile' home/.chezmoiignore.tmpl || {
  echo "home/.chezmoiignore.tmpl must read .defaults.profile" >&2
  exit 1
}

grep -q 'index \.defaults \$profile' home/.chezmoiignore.tmpl || {
  echo "home/.chezmoiignore.tmpl must read profile defaults from .defaults" >&2
  exit 1
}

grep -q 'if not \$profileDefaults' home/.chezmoiignore.tmpl || {
  echo "home/.chezmoiignore.tmpl must fall back when a profile override has no defaults" >&2
  exit 1
}

grep -q 'hasKey \. \"features\"' home/.chezmoiignore.tmpl || {
  echo "home/.chezmoiignore.tmpl must allow later feature overrides" >&2
  exit 1
}
