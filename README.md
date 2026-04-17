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
gh repo clone andocodes/dotfiles ~/Projects/dotfiles
cd ~/Projects/dotfiles
./scripts/bootstrap --profile full
```

## Profiles

- `full`: install the complete supported experience for the current machine
- `minimal`: install only the lean survival stack

## Useful Commands

```sh
mise run doctor -- --profile full
mise run test-phase1
chezmoi apply
```
