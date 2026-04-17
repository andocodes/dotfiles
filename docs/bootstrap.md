# Bootstrap

## Supported package managers

- Homebrew
- apt
- dnf
- pacman

## First-run flow

1. Clone the repo with Git: `git clone https://github.com/andocodes/dotfiles.git ~/Projects/dotfiles`
2. Change into the repo: `cd ~/Projects/dotfiles`
3. If you prefer GitHub CLI, `gh repo clone andocodes/dotfiles ~/Projects/dotfiles` is also fine.
4. Run `./scripts/bootstrap --profile full`.
5. Confirm the generated local chezmoi profile in `~/.config/chezmoi/chezmoi.toml`.
6. Run `mise trust .mise.toml`.
7. Run `mise install`.
8. Run `mise run test-phase1`.
