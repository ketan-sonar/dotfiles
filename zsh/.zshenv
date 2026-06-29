export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export EDITOR="nvim"
export VISUAL="nvim"

export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export GOPATH="$HOME/Developer/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"

export MANPAGER="nvim +Man!"

export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fnm env --use-on-cd --shell zsh)"
