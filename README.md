# dotfiles

tmux-first, XDG-first dotfiles for macOS and Linux.

## Stack

- chezmoi
- zsh
- tmux
- LazyVim
- Yazi
- lazygit
- lazydocker
- mise
- Tailscale

## Bootstrap

```sh
git clone https://github.com/andocodes/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
./scripts/bootstrap --profile full
mise trust .mise.toml
mise install
mise run test-phase1
```

If you already have GitHub CLI installed, `gh repo clone andocodes/dotfiles ~/Projects/dotfiles` works too.

## Profiles

- `full`: install the complete supported experience for the current machine
- `minimal`: install only the lean survival stack

## Useful Commands

```sh
mise run doctor -- --profile full
mise run test-phase1
chezmoi apply
```
