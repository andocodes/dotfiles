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
grep -q '^go = "latest"$' .mise.toml
grep -q '^node = "lts"$' .mise.toml
grep -q '^python = "3.13"$' .mise.toml
grep -q '^rust = "stable"$' .mise.toml
grep -q '^uv = "latest"$' .mise.toml
grep -q '^bun = "latest"$' .mise.toml
grep -q '^kubectl = "latest"$' .mise.toml
grep -q '^terramate = "latest"$' .mise.toml

grep -q '^\[tasks.bootstrap\]' .mise.toml
grep -q '^\[tasks.doctor\]' .mise.toml
grep -q '^\[tasks.test-repo\]' .mise.toml
grep -q 'sh scripts/bootstrap' .mise.toml
grep -q 'sh scripts/doctor' .mise.toml
grep -q 'sh tests/smoke/repo_layout.sh' .mise.toml
grep -q 'sh tests/smoke/chezmoi_layout.sh' .mise.toml
grep -q 'sh tests/smoke/scripts.sh' .mise.toml
grep -q 'sh tests/smoke/mise.sh' .mise.toml

grep -q '^\[settings\]' home/dot_config/mise/config.toml
grep -q '^experimental = true$' home/dot_config/mise/config.toml
grep -q '^status.missing_tools = "always"$' home/dot_config/mise/config.toml
grep -q '^idiomatic_version_file_enable_tools = \["node", "python", "rust"\]$' home/dot_config/mise/config.toml
