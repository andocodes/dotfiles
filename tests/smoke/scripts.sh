#!/bin/sh
set -eu

for path in scripts/bootstrap scripts/doctor scripts/secret; do
  [ -x "$path" ] || {
    echo "missing or not executable: $path" >&2
    exit 1
  }
done

sh -n scripts/bootstrap
sh -n scripts/doctor
sh -n scripts/secret
