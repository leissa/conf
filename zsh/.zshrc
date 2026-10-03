export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org https://debuginfod.elfutils.org"

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER="nvimpager"
export CMAKE_EXPORT_COMPILE_COMMANDS=1
export BAT_THEME=tokyonight

#
# oh-my-zsh
#

# The prompt comes from starship (initialized at the bottom of this file),
# so oh-my-zsh must not install a theme of its own.
ZSH_THEME=""

VI_MODE_SET_CURSOR=true

# eza

zstyle ':omz:plugins:eza' 'dirs-first'  yes
zstyle ':omz:plugins:eza' 'git-status'  yes
zstyle ':omz:plugins:eza' 'header'      no
# hyperlink is added below: the plugin's bare `--hyperlink` swallows a following path
zstyle ':omz:plugins:eza' 'hyperlink'   no
zstyle ':omz:plugins:eza' 'icons'       yes
zstyle ':omz:plugins:eza' 'size-prefix' binary

# completion

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# group matches under colored descriptions
zstyle ':completion:*:descriptions' format '%F{yellow}[%d]%f'
zstyle ':completion:*' group-name ''

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# pick up newly installed binaries without `rehash`
zstyle ':completion:*' rehash true

plugins=(
    aliases
    archlinux
    colorize
    dotenv
    eza
    git
    kitty
    zoxide
    vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
)

export ZSH="$HOME/.config/zsh/oh-my-zsh"
export ZSH_CUSTOM="$HOME/.config/zsh/custom"
source $ZSH/oh-my-zsh.sh

# complete dotfiles without typing the leading `.`; otherwise `git add <TAB>`
# inside a stow package (where every path is .zshrc, .config/...) finds nothing
_comp_options+=(globdots)

#
# aliases
#

alias icat="kitten icat"
alias picard="picard -s"

# eza: translate ls-style flags in short-option clusters (`ls -ltr`, `l -lS`):
#   t → -s modified, S → -s size (ls sorts these descending, eza ascending, so -r flips)
#   h → dropped (eza sizes are human-readable anyway; its -h adds a header)
# eza's own `-t FIELD`/`-s FIELD`/... still work since value-taking options end a cluster
function _eza_ls() {
  local -a args
  local arg rest c kept sort
  integer reverse=0
  while (( $# )); do
    arg=$1; shift
    if [[ $arg == -- ]]; then args+=(-- "$@"); break; fi
    if [[ $arg != -[^-]* ]]; then args+=($arg); continue; fi
    rest=${arg#-} kept=
    while [[ -n $rest ]]; do
      c=${rest[1]} rest=${rest:1}
      case $c in
        t) if [[ $rest == (modified|changed|accessed|created) ]] ||
              [[ -z $rest && $1 == (modified|changed|accessed|created) ]]; then
             kept+=t$rest; break
           fi
           sort=modified ;;
        S) sort=size ;;
        r) (( reverse ^= 1 )) ;;
        h) ;;
        [sLwIF]) kept+=$c$rest; break ;;
        *) kept+=$c ;;
      esac
    done
    [[ -n $kept ]] && args+=(-$kept)
  done
  [[ -n $sort ]] && { args+=(-s $sort); (( reverse ^= 1 )) }
  (( reverse )) && args+=(-r)
  eza "${args[@]}"
}

# eza: route the plugin's aliases through _eza_ls and add hyperlinks (see the zstyle above)
for _a in ${(k)aliases}; do
  [[ $aliases[$_a] == eza\ * ]] && aliases[$_a]="_eza_ls ${aliases[$_a]#eza } --hyperlink=auto"
done
unset _a

#
# fzf
#

eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS="
    --highlight-line
    --info=inline-right
    --ansi
    --layout=reverse
    --border=none
    --color=bg+:#283457
    --color=border:#27a1b9
    --color=fg:#c0caf5
    --color=gutter:#16161e
    --color=header:#ff9e64
    --color=hl+:#2ac3de
    --color=hl:#2ac3de
    --color=info:#545c7e
    --color=marker:#ff007c
    --color=pointer:#ff007c
    --color=prompt:#2ac3de
    --color=query:#c0caf5:regular
    --color=scrollbar:#27a1b9
    --color=separator:#ff9e64
    --color=spinner:#ff007c
"

# List files/dirs with fd: respects .gitignore (fzf's built-in walker doesn't)
_fzf_fd="fd --hidden --follow --exclude .git --exclude node_modules --exclude target"
export FZF_CTRL_T_COMMAND="$_fzf_fd --type f"
export FZF_ALT_C_COMMAND="$_fzf_fd --type d"
# `**<TAB>` without a path prefix passes "."; list relative to cwd without "./"
_fzf_compgen_path() { [[ $1 == . ]] && eval "$_fzf_fd --strip-cwd-prefix"         || eval "$_fzf_fd . ${(q)1}" }
_fzf_compgen_dir()  { [[ $1 == . ]] && eval "$_fzf_fd --strip-cwd-prefix --type d" || eval "$_fzf_fd --type d . ${(q)1}" }

# fzf reads FZF_DEFAULT_OPTS on its own; the per-widget opts below only add to it

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using wl-copy
export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window up:3:hidden:wrap
    --bind 'ctrl-/:toggle-preview'
    --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
    --header 'Press CTRL-Y to copy command into clipboard'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
    --preview 'tree -C {}'"

# `**<TAB>` completion ignores FZF_CTRL_T_OPTS; add previews per command here
_fzf_comprun() {
    local command=$1
    shift
    case "$command" in
        cd)           fzf --preview 'tree -C {} | head -200' "$@" ;;
        export|unset) fzf --preview "eval 'echo \$'{}"       "$@" ;;
        ssh|telnet)   fzf "$@" ;;
        *)            fzf --preview '[[ -d {} ]] && tree -C {} | head -200 || bat -n --color=always {}' \
                          --bind 'ctrl-/:change-preview-window(down|hidden|)' "$@" ;;
    esac
}

# live ripgrep: type to search, preview the hit, <Enter> opens it in nvim at that line
rgf() {
    fzf --disabled --ansi --query "$*" \
        --bind 'start,change:reload:rg --column --line-number --no-heading --color=always --smart-case -- {q} || true' \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,+{2}+3/3' \
        --bind 'enter:become(nvim {1} +{2})'
}

# git pickers (https://github.com/junegunn/fzf-git.sh):
# CTRL-G CTRL-{F,B,T,R,H,S,E,L,W} for files, branches, tags, remotes, hashes, stashes, each-ref, reflog, worktrees
source "$ZSH_CUSTOM/fzf-git/fzf-git.sh"

#
# toolchains
#

source "$HOME/.elan/env"
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null
source $HOME/.config/broot/launcher/bash/br

#
# prompt: starship -- config in ~/.config/starship.toml
#

ZLE_RPROMPT_INDENT=0  # flush right prompt against the terminal edge (like p10k)
eval "$(starship init zsh)"
