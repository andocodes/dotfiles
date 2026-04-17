#!/bin/sh
set -eu

[ -f home/run_onchange_install-packages.sh.tmpl ] || {
  echo "missing home/run_onchange_install-packages.sh.tmpl" >&2
  exit 1
}

grep -q 'tailscale-ssh' home/.chezmoidata/features.yaml
grep -q 'test-phase1' .mise.toml
