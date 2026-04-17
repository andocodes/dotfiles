#!/bin/sh
set -eu

for path in README.md .gitignore .chezmoiroot docs/architecture.md docs/bootstrap.md home scripts tests/smoke; do
  [ -e "$path" ] || {
    echo "missing $path" >&2
    exit 1
  }
done
