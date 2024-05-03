# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc. Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

export EDITOR=nvim
export VISUAL=nvim
export PAGER="nvimpager"
export PATH="/home/roland/.local/share/gem/ruby/3.0.0/bin:/usr/lib/ccache/bin/:$PATH:/home/roland/thorin2/build/bin"
export CMAKE_EXPORT_COMPILE_COMMANDS=1

# autocomplete
zstyle :compinstall filename '/home/roland/.zshrc'
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

# alias
alias pacman="pacman --color=auto"
#alias yay="yay --color auto --noconfirm"
alias ls="ls --color=auto"
alias ll="ls -l --group-directories-first"
alias gdb="gdb -q"

# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf

zvm_after_init() {
    eval "$(fzf --zsh)"
}


# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
    --walker-skip .git,node_modules,target
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window up:3:hidden:wrap
    --bind 'ctrl-/:toggle-preview'
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
    --color header:italic
    --header 'Press CTRL-Y to copy command into clipboard'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
    --walker-skip .git,node_modules,target
    --preview 'tree -C {}'"


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

#zinit light-mode for \
    #zinit-zsh/z-a-rust \
    #zinit-zsh/z-a-as-monitor \
    #zinit-zsh/z-a-patch-dl \
    #zinit-zsh/z-a-bin-gem-node

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit load jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-syntax-highlighting
