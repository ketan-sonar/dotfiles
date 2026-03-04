# vi mode
bindkey -v

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fnm env --use-on-cd --shell zsh)"

# setup auto completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Za-z}'

# prompt setup
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

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
export TERM="tmux-256color"
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
export PATH="/opt/homebrew/Caskroom/geany/2.1/Geany.app/Contents/MacOS:$PATH"
# export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
# export CPPFLAGS="-I/opt/homebrew/opt/openjdk@21/include"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/ketan/.dart-cli-completion/zsh-config.zsh ]] && . /Users/ketan/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

fpath+=("$(brew --prefix)/share/zsh/site-functions")

source <(fzf --zsh)

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Added by Antigravity
export PATH="/Users/ketan/.antigravity/antigravity/bin:$PATH"
