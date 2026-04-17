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

command -v chezmoi >/dev/null 2>&1 || {
  echo "chezmoi is required for tests/smoke/chezmoi_layout.sh" >&2
  exit 1
}

source_dir="$PWD/home"
template_file="$source_dir/.chezmoiignore.tmpl"

default_render=$(chezmoi execute-template --file -S "$source_dir" "$template_file" | sed '/^$/d')
[ -z "$default_render" ] || {
  echo "default profile should not ignore enabled full-profile tools" >&2
  exit 1
}

minimal_render=$(chezmoi execute-template --file -S "$source_dir" --override-data '{"profile":"minimal"}' "$template_file" | sed '/^$/d')
expected_minimal=$(cat <<'EOF'
.config/ghostty/**
.config/lazydocker/**
.config/yazi/**
EOF
)
[ "$minimal_render" = "$expected_minimal" ] || {
  echo "minimal profile render mismatch" >&2
  printf '%s\n' "$minimal_render" >&2
  exit 1
}

override_render=$(chezmoi execute-template --file -S "$source_dir" --override-data '{"profile":"minimal","features":{"gui":true,"docker":true,"yazi":true}}' "$template_file" | sed '/^$/d')
[ -z "$override_render" ] || {
  echo "explicit feature overrides must win over minimal defaults" >&2
  exit 1
}
