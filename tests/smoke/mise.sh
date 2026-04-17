#!/bin/sh
set -eu

[ -f .mise.toml ] || {
  echo "missing .mise.toml" >&2
  exit 1
}

[ -f home/dot_config/mise/config.toml ] || {
  echo "missing home/dot_config/mise/config.toml" >&2
  exit 1
}

grep -q '^\[tools\]' .mise.toml
grep -q 'doctor' .mise.toml
