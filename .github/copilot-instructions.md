# Copilot Instructions

## Repository Overview

This is a personal dotfiles repository managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow *package* whose internal structure mirrors `$HOME`.

**Example:** `nvim/.config/nvim/init.lua` → symlinked to `~/.config/nvim/init.lua`

## Deployment

```bash
make        # init missing submodules, stow all packages (create symlinks in $HOME), rebuild bat's theme cache if a theme changed
make check  # dry run: show what `make` would do, including conflicts
make delete # unstow all packages (remove symlinks)
```

These invoke `stow --restow */`, `stow --no --restow */` and `stow --delete */`. The flags `--target=~ --verbose` come from `.stowrc` in the repo root, so a single package can be (un)stowed from the repo with a bare `stow nvim` / `stow -D kitty`.

`make` only runs `git submodule update --init --recursive` when a submodule is still uninitialized; it never resets submodules that are already checked out.

**Only directories are stowed** — every top-level directory except `stuff/` (see below). A new file added at the repo root is *not* deployed.

Stow silently skips a few names in every package by default, notably `.gitignore`, `.gitmodules`, `README*` and `LICENSE*`. A file with one of those names inside a package is never linked, so use an alternative path (e.g. the global gitignore lives at `git/.config/git/ignore`, git's XDG default).

There is no build, no test suite and no linter. "Correct" means: the file is valid for its tool, and the package layout still maps to the right place in `$HOME`.

The repo is expected to live at `~/projects/conf`.

## Repository Structure

| Package | Target path | Purpose |
|---------|------------|---------|
| `nvim/` | `~/.config/nvim/` | Neovim config (LazyVim-based) |
| `zsh/` | `~/.config/zsh/` + `~/.zshrc` | Zsh + oh-my-zsh config |
| `kitty/` | `~/.config/kitty/` | Kitty terminal config |
| `git/` | `~/.gitconfig`, `~/.config/git/ignore` | Git global config + global ignore (read by default, no `excludesfile`) |
| `env/` | `~/.config/environment.d/` | Systemd user env vars |
| `bat/` | `~/.config/bat/` | bat custom themes (`tokyonight.tmTheme`); `make` runs `bat cache --build` when a theme is newer than bat's cache |
| `broot/` | `~/.config/broot/` | broot file manager |
| `cgdb/` | `~/.cgdb/` | cgdb debugger |
| `picard/` | `~/.config/MusicBrainz/` | MusicBrainz Picard |
| `presenterm/` | `~/.config/presenterm/` | presenterm terminal slides |
| `starship/` | `~/.config/starship.toml`, `~/.config/starship/` | Starship prompt config + the git segment's helper script |
| `claude/` | `~/.claude/` | Claude Code settings + its starship statusline wrapper |

A config for a new tool *foo* goes in `foo/.config/foo/…`, never at the repo root.

### Unstowed files

`stuff/` holds standalone helper scripts (`linediff.sh`, `24-bit-color.sh`, `trucolor-test.sh`) that are kept but not deployed; the Makefile filters it out of the package list. Run them from the repo.

`.ignore` (repo-local, read by rg/fd and everything built on them) whitelists dot entries (`!.*`, minus `.git`) so searches descend into the packages' `.config/` etc. instead of skipping them as hidden.

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
- `custom/fzf-git` — [fzf-git.sh](https://github.com/junegunn/fzf-git.sh), sourced directly from `zsh/.zshrc` (it is not an oh-my-zsh plugin)

Never edit files inside a submodule to change behaviour — override via `zsh/.zshrc` or `custom/`.

oh-my-zsh sources every `custom/*.zsh` automatically. `custom/git-files.zsh` is such an override: a fixed copy of `__git_files` from zsh's own `_git` completion (its pathspec quoting is broken, so `git add ../foo/<TAB>` from a subdirectory found nothing).

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

The prompt is [Starship](https://starship.rs/), not an oh-my-zsh theme: `zsh/.zshrc` sets `ZSH_THEME=""` so oh-my-zsh installs no prompt of its own, and runs `eval "$(starship init zsh)"` at the very end of the file. Prompt changes belong in `starship/.config/starship.toml`. (Powerlevel10k, its `p10k/` package and its submodule were removed.)

`starship.toml` sets `format` and `right_format` explicitly, so **a module that is not named in one of them does not render**, however it is configured. The left side is the powerline chain `os → directory → custom.git → character`; the right side is one bar on `bar_bg` holding the toolchain modules, then `status` / `cmd_duration` / `jobs` / `shlvl`, then the clock. Every right-side module is formatted as `[ <content>]` with no trailing space -- only `$time` closes the bar -- so segments never double-space.

Two things worth knowing before adding a module:

- **`when` in a `[custom.*]` module defaults to `false`**, not true. `require_repo`/`detect_files` alone will never render; set `when = true` as well.
- **Format variables are evaluated lazily.** Leaving `$version` out of a language module's format skips the subprocess that computes it. That is why `[python]` is virtualenv-only (~11ms instead of ~60ms for a `pyenv version-name` that only ever prints `system`).

`starship timings` prints the per-module cost for the current directory; use it before adding anything that shells out.

Key environment:
- `$EDITOR` / `$VISUAL` = `nvim`
- `$PAGER` = `nvimpager`
- `$BAT_THEME` = `tokyonight`
- `$CMAKE_EXPORT_COMPILE_COMMANDS=1` (always generate compile_commands.json)
- Uses `pyenv`, `opam`, `elan` (Lean), and `broot`

## Claude Code

`claude/.claude/settings.json` sets a `statusLine` pointing at
`claude/.claude/starship-statusline.sh`, which pipes the session JSON into
`starship statusline claude-code` -- the `[profiles] claude-code` format string in
`starship.toml`. The wrapper exists because starship resolves path-based modules
from its own working directory, never from the JSON's `workspace.current_dir`, so
it digs that field out with `jq` and passes it as `-p`.

The `claude_model` / `claude_context` / `claude_cost` modules are new in starship
1.26 and are not on starship.rs yet; `starship print-config` and the bundled
`config-schema.json` are the reference. They, and the plain `git_branch` /
`git_status` / `git_metrics` modules, are used **only** by that profile -- the
interactive prompt uses `custom.git` instead.

Only those two files are stowed; the rest of `~/.claude/` is machine-local state.
Note that Claude Code rewrites `settings.json` itself when you change the model or
theme from inside the app, so expect that file to pick up edits you did not make.

## Theming Convention

Tokyo Night is used consistently across all tools:
- Neovim: `tokyonight` colorscheme
- bat: `$BAT_THEME=tokyonight`, which names `bat/.config/bat/themes/tokyonight.tmTheme` -- bat has no built-in Tokyo Night, so the theme only exists after `bat cache --build` (done by `make`)
- fzf: Tokyo Night color palette in `$FZF_DEFAULT_OPTS`
- kitty: themed via `current-theme.conf` (gitignored, set by kitty's theme switcher)
- presenterm: `theme: tokyonight-night`
- starship: the palette is named -- `[palettes.tokyonight]` in `starship.toml`, selected with `palette = "tokyonight"`, and referenced by name (`fg:green bg:blue0`) rather than by hex. Its colour names deliberately shadow the ANSI ones, so modules left at their defaults pick up the theme too. The git segment is `custom.git` (p10k rainbow port: green = clean, yellow = modified), not the built-in `git_branch`/`git_status`
- the one place hex is still written out is `starship/.config/starship/git-segment.sh`, which emits its own SGR escape because starship cannot interpolate the palette into a custom module's output -- keep those two values in sync with the palette

When adding new tool configs, use Tokyo Night where the tool supports theming.
