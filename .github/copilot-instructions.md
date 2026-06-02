# Copilot Instructions

## Repository Overview

This is a personal dotfiles repository managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow *package* whose internal structure mirrors `$HOME`.

**Example:** `nvim/.config/nvim/init.lua` → symlinked to `~/.config/nvim/init.lua`

## Deployment

```bash
make        # stow all packages (create symlinks in $HOME)
make delete # unstow all packages (remove symlinks)
```

These invoke `stow --verbose --target=$HOME --restow */` and `--delete */` respectively.

> **Note:** Root-level files (`.bashrc`, `.tmux.conf`) are not part of any stow package and must be managed separately.

## Repository Structure

| Package | Target path | Purpose |
|---------|------------|---------|
| `nvim/` | `~/.config/nvim/` | Neovim config (LazyVim-based) |
| `zsh/` | `~/.config/zsh/` + `~/.zshrc` | Zsh + oh-my-zsh config |
| `kitty/` | `~/.config/kitty/` | Kitty terminal config |
| `tmux/` | (root `.tmux.conf`) | tmux config |
| `git/` | `~/.gitconfig`, `~/.gitignore` | Git global config |
| `env/` | `~/.config/environment.d/` | Systemd user env vars |
| `broot/` | `~/.config/broot/` | broot file manager |
| `cgdb/` | `~/.cgdb/` | cgdb debugger |
| `picard/` | `~/.config/MusicBrainz/` | MusicBrainz Picard |
| `p10k/` | (p10k theme file) | Powerlevel10k prompt config |

## Git Submodules

Zsh plugins and oh-my-zsh itself are git submodules:

```bash
git submodule update --init --recursive   # initialize after cloning
git get                                   # alias: fetch --all --recurse-submodules --tags
```

Submodules live under `zsh/.config/zsh/`:
- `oh-my-zsh/` — oh-my-zsh framework (stored at `~/.config/zsh/oh-my-zsh`, not `~/.oh-my-zsh`)
- `custom/plugins/zsh-autosuggestions`
- `custom/plugins/zsh-syntax-highlighting`
- `custom/plugins/alias-tips`
- `custom/themes/powerlevel10k`

## Neovim Configuration

Built on [LazyVim](https://www.lazyvim.org/). Entry point: `nvim/.config/nvim/init.lua`.

**Structure:**
- `lua/config/` — core config (keymaps, options, lazy setup, autocmds)
- `lua/plugins/` — plugin specs that extend/override LazyVim defaults

**Key settings:**
- No autoformat on save (`g.autoformat = false`) — format manually
- 4-space indentation, tabs expanded
- `maplocalleader = "ö"` (German keyboard layout)
- `<F11>` runs `:make! -j$(nproc)`, useful for C/C++ projects
- `q:` disabled (use `q::` instead)

**Plugin notes:**
- Colorscheme: Tokyo Night
- `lua/plugins/disabled.lua` — lists LazyVim defaults that have been disabled
- `stylua.toml` configures Lua formatting

## Zsh Configuration

oh-my-zsh is stored at `~/.config/zsh/oh-my-zsh` (non-standard), with custom plugins/themes at `~/.config/zsh/custom/`. Active plugins are listed in `zsh/.zshrc`.

Key environment:
- `$EDITOR` / `$VISUAL` = `nvim`
- `$PAGER` = `nvimpager`
- `$BAT_THEME` = `tokyonight`
- `$CMAKE_EXPORT_COMPILE_COMMANDS=1` (always generate compile_commands.json)
- Uses `pyenv`, `opam`, `elan` (Lean), and `broot`

## tmux Configuration

- TPM (tmux Plugin Manager) — installed via `~/projects/conf/tpm_install.sh`
- Prefix: `C-Space` (not default `C-b`)
- Theme: `fabioluciano/tmux-tokyo-night` (night variant)

## Theming Convention

Tokyo Night is used consistently across all tools:
- Neovim: `tokyonight` colorscheme
- tmux: `tmux-tokyo-night`
- bat: `$BAT_THEME=tokyonight`
- fzf: Tokyo Night color palette in `$FZF_DEFAULT_OPTS`
- kitty: themed via `current-theme.conf` (gitignored, set by kitty's theme switcher)

When adding new tool configs, use Tokyo Night where the tool supports theming.
