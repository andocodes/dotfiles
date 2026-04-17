# Bootstrap

## Supported package managers

- Homebrew
- apt
- dnf
- pacman

## First-run flow

1. Clone the repo.
2. Run `./scripts/bootstrap --profile full`.
3. Confirm the generated local chezmoi profile in `~/.config/chezmoi/chezmoi.toml`.
4. Run `mise install`.
5. Run `mise run test-phase1`.
