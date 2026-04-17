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

if command -v chezmoi >/dev/null 2>&1; then
  source_dir="$PWD/home"
  template_file="$source_dir/.chezmoiignore.tmpl"

  default_render=$(chezmoi execute-template --file -S "$source_dir" "$template_file")
  [ -z "$default_render" ] || {
    echo "default profile should not ignore enabled full-profile tools" >&2
    exit 1
  }

  minimal_render=$(chezmoi execute-template --file -S "$source_dir" --override-data '{"profile":"minimal"}' "$template_file")
  printf '%s\n' "$minimal_render" | grep -qx '.config/ghostty/\*\*' || {
    echo "minimal profile should ignore ghostty by default" >&2
    exit 1
  }
  printf '%s\n' "$minimal_render" | grep -qx '.config/lazydocker/\*\*' || {
    echo "minimal profile should ignore lazydocker by default" >&2
    exit 1
  }
  printf '%s\n' "$minimal_render" | grep -qx '.config/yazi/\*\*' || {
    echo "minimal profile should ignore yazi by default" >&2
    exit 1
  }

  override_render=$(chezmoi execute-template --file -S "$source_dir" --override-data '{"profile":"minimal","features":{"gui":true,"docker":true,"yazi":true}}' "$template_file")
  [ -z "$override_render" ] || {
    echo "explicit feature overrides must win over minimal defaults" >&2
    exit 1
  }
fi
