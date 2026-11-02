# conf

My dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Everything is themed with Tokyo Night where the tool allows it.

Each top-level directory is a stow *package* whose layout mirrors `$HOME`,
e.g. `nvim/.config/nvim/init.lua` becomes `~/.config/nvim/init.lua`.

## Install

```sh
git clone --recursive git@github.com:leissa/conf.git ~/projects/conf
cd ~/projects/conf
make check   # dry run: show what would be linked and any conflicts
make         # link all packages into $HOME
```

`make` also initializes missing submodules and rebuilds bat's theme cache when needed.
`make delete` removes all links again.
A single package can be (un)stowed directly, e.g. `stow nvim` or `stow -D kitty`
(`--target=~` comes from `.stowrc`).

The repo is expected to live at `~/projects/conf`.

## Packages

| Package       | What                                                                |
|---------------|---------------------------------------------------------------------|
| `nvim`        | Neovim, based on [LazyVim](https://www.lazyvim.org/)                |
| `zsh`         | zsh + oh-my-zsh (plugins as submodules), fzf, eza                   |
| `starship`    | [Starship](https://starship.rs/) prompt                             |
| `kitty`       | kitty terminal                                                      |
| `git`         | global git config and ignore                                        |
| `env`         | systemd user environment (ssh-agent, ksshaskpass)                   |
| `bat`         | bat with a Tokyo Night theme                                        |
| `broot`       | broot file manager                                                  |
| `cgdb`        | cgdb debugger                                                       |
| `presenterm`  | presenterm terminal slides                                          |
| `picard`      | MusicBrainz Picard + a small `cover_from_release` plugin            |
| `claude`      | Claude Code settings + a starship-based status line                 |

`stuff/` holds standalone helper scripts that are not deployed.

## Dependencies

`stow` and `make`, plus whichever tools you want configured.
The shell setup assumes `nvim`, `starship`, `fzf`, `fd`, `bat`, `eza`, `zoxide` and `nvimpager`.

## Notes

Machine-local state (`lazy-lock.json`, Picard's `Picard.ini`, kitty's `current-theme.conf`, …) is gitignored.
More details on conventions and layout are in [`.github/copilot-instructions.md`](.github/copilot-instructions.md).
