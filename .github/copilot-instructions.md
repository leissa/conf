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

Note the trailing `*/`: **only directories are stowed**. A new file added at the repo root is *not* deployed.

There is no build, no test suite and no linter. "Correct" means: the file is valid for its tool, and the package layout still maps to the right place in `$HOME`.

The repo is expected to live at `~/projects/conf` — `.tmux.conf` hardcodes `~/projects/conf/tpm_install.sh`.

## Repository Structure

| Package | Target path | Purpose |
|---------|------------|---------|
| `nvim/` | `~/.config/nvim/` | Neovim config (LazyVim-based) |
| `zsh/` | `~/.config/zsh/` + `~/.zshrc` | Zsh + oh-my-zsh config |
| `kitty/` | `~/.config/kitty/` | Kitty terminal config |
| `git/` | `~/.gitconfig`, `~/.gitignore` | Git global config |
| `env/` | `~/.config/environment.d/` | Systemd user env vars |
| `broot/` | `~/.config/broot/` | broot file manager |
| `cgdb/` | `~/.cgdb/` | cgdb debugger |
| `picard/` | `~/.config/MusicBrainz/` | MusicBrainz Picard |
| `presenterm/` | `~/.config/presenterm/` | presenterm terminal slides |
| `p10k/` | `~/.p10k.zsh` | Powerlevel10k prompt config |

A config for a new tool *foo* goes in `foo/.config/foo/…`, never at the repo root.

### Unstowed root-level files

Not part of any package; managed by hand (link/copy them into place yourself):
`.bashrc`, `.tmux.conf`, `tokyonight.tmTheme`, `typst.lua`, and the helper scripts
`tpm_install.sh`, `ssh-agent-startup.sh`, `ssh-agent-logout.sh`, `linediff.sh`, `24-bit-color.sh`, `trucolor-test.sh`.

### Machine-local files

Present in the working tree but gitignored — never commit them and don't try to "restore" them:
`nvim/.config/nvim/lazy-lock.json`, `nvim/.config/nvim/lazyvim.json`,
`kitty/.config/kitty/current-theme.conf` (written by kitty's theme switcher),
`picard/.config/MusicBrainz/Picard.ini`, `cgdb/.cgdb/logs/`.

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

Never edit files inside a submodule to change behaviour — override via `zsh/.zshrc` or `custom/`.

## Neovim Configuration

Built on [LazyVim](https://www.lazyvim.org/). Entry point: `nvim/.config/nvim/init.lua` → `lua/config/lazy.lua`, which bootstraps lazy.nvim, imports `lazyvim.plugins`, then every file in `lua/plugins/`.

**Structure:**
- `lua/config/` — core config (keymaps, options, lazy setup, autocmds)
- `lua/plugins/` — one file per plugin (or small topic), each returning a lazy.nvim spec table

**Key settings:**
- No autoformat on save (`g.autoformat = false`) — format manually
- 4-space indentation, tabs expanded
- `maplocalleader = "ö"` (German keyboard layout)
- `<F11>` runs `:make! -j$(nproc)`, useful for C/C++ projects
- `q:` disabled (use `q::` instead)

**Plugin notes:**
- Colorscheme: Tokyo Night
- To turn off a LazyVim default, add `{ "repo/name", enabled = false }` to `lua/plugins/disabled.lua` — don't delete anything
- Two stylua configs, deliberately different: `nvim/.config/nvim/stylua.toml` is 2-space (LazyVim style, applies to `lua/config/`), `lua/plugins/stylua.toml` is 4-space and governs the plugin specs. Match the directory you are editing.

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
- presenterm: `theme: tokyonight-night`
- `tokyonight.tmTheme` for TextMate-grammar consumers

When adding new tool configs, use Tokyo Night where the tool supports theming.
