set -eu

if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    mkdir -p ~/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

