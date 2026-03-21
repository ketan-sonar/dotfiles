eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fnm env --use-on-cd --shell zsh)"

# aliases
alias ls="eza --group-directories-first"
alias la="eza -lah --group-directories-first"
alias tree="ls --tree"
alias vi="nvim"
alias flutter="fvm flutter"
alias dart="fvm dart"
alias tn="tmux new"
alias ta="tmux a"
alias tl="tmux ls"
alias gcc="gcc-15"
alias g++="g++-15"
alias get_idf="source ~/Developer/esp/esp-idf/export.sh"
alias lg="lazygit"

# exports
export TERM="xterm-256color"
export EDITOR="nvim"
export PATH="/opt/homebrew/bin:$PATH"
export GOPATH="$HOME/Developer/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"

fpath+=("$(brew --prefix)/share/zsh/site-functions")

source <(fzf --zsh)
