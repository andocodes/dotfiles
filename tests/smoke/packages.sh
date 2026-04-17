#!/bin/sh
set -eu

[ -f home/run_onchange_install-packages.sh.tmpl ] || {
  echo "missing home/run_onchange_install-packages.sh.tmpl" >&2
  exit 1
}

grep -q 'tailscale-ssh' home/.chezmoidata/features.yaml
grep -q 'test-phase1' .mise.toml
grep -q 'https://starship.rs/install.sh' home/run_onchange_install-packages.sh.tmpl

if awk '
  /^[[:space:]]{2}(darwin|debian|fedora|arch):$/ { platform = $1; next }
  /^[[:space:]]{4}(core|runtimes|tui|docker|tailscale):$/ { group = $1; next }
  ((platform == "debian:" || platform == "fedora:") && group == "core:" && /- starship$/) {
    exit 0
  }
  END { exit 1 }
' home/.chezmoidata/packages.yaml
then
  echo "linux core package lists still install starship directly" >&2
  exit 1
fi
