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

sh scripts/bootstrap --help >/dev/null
sh scripts/doctor --help >/dev/null
sh scripts/secret >/dev/null

if sh scripts/bootstrap --profile bogus >/dev/null 2>&1; then
  echo "scripts/bootstrap accepted an invalid profile" >&2
  exit 1
fi

if sh scripts/doctor --profile bogus >/dev/null 2>&1; then
  echo "scripts/doctor accepted an invalid profile" >&2
  exit 1
fi
