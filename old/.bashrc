# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -F'
alias ll='ls -l'
#alias vim='nvim'
#alias vim='nvim --servername VIM'
alias vim='nvim'
alias vi='vim'
alias vimdiff='nvim -d'

PS1='\[\e[0;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '

export EDITOR="nvim"
#export NVIM_TUI_ENABLE_TRUE_COLOR=1
#export PATH=/home/roland/bin:/home/leissa/bin:$PATH
#export PATH=/home/roland/bin:/home/leissa/projects/anydsl/impala/build/bin/:/home/roland/projects/anydsl/impala/build/bin/:/home/roland/bin:/home/leissa/bin:$PATH
export PATH=/home/roland/bin:/home/leissa/bin:/home/roland/.gem/ruby/2.4.0/bin:$PATH
#export PATH=/home/leissa/projects/anydsl/thorin/build/bin/:/home/roland/bin:/home/leissa/bin:$PATH
#export LD_LIBRARY_PATH="$HOME/bin"

#PROMPT_COMMAND='echo -ne "\033k\033\134"'
#PROMPT_COMMAND='echo -ne "\033k\033"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#
# for cdl password stash
#

cdlpass_dir=/home/roland/projects/pass
cdlpass() {
    (cd "$cdlpass_dir" && exec ./git-pass "${@}")
}

_cdlpass() {
    . /usr/share/bash-completion/completions/pass
    PASSWORD_STORE_DIR="$cdlpass_dir/cdl/" _pass
}

complete -o filenames -o nospace -F _cdlpass cdlpass

#unlimted .bash_history
HISTSIZE= 
HISTFILESIZE=
