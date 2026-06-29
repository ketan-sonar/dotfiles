### SETTINGS ###

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

if [[ -n "$ZDOTDIR/completions" ]]; then
    fpath=("$ZDOTDIR/completions" $fpath)
fi

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ":completion:*" menu select
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"

source <(fzf --zsh)

### ALIASES ###

alias vi="nvim"
alias ls="eza --group-directories-first"
alias ll="ls -lh"
alias la="ls -lah"
alias tree="ls --tree"
alias tn="tmux new"
alias ta="tmux a"
alias tl="tmux ls"
alias gcc="gcc-15"
alias g++="g++-15"
alias lg="lazygit"
alias gst="git status"

compdef eza=ls

### PLUGINS ###

ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

_zplugin_load() {
    local plugin_path="${ZPLUGINDIR}/${2}"
    if [[ ! -d "$plugin_path" ]]; then
        mkdir -p "$ZPLUGINDIR"
        echo "Installing ${2}..."
        git clone --depth=1 "git@github.com:${1}/${2}" "$plugin_path" \
            || { echo "ERROR: failed to install ${2}" >&2; return 1; }
    fi
    source "${plugin_path}/${2}.plugin.zsh"
}

zplugin-update() {
    local dir
    for dir in "${ZPLUGINDIR}"/*/; do
        echo "Updating ${dir:t}..."
        git -C "$dir" pull --ff-only
    done
}

_zplugin_load zdharma-continuum fast-syntax-highlighting
_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load zsh-users zsh-history-substring-search
_zplugin_load jeffreytse zsh-vi-mode

### KEYBINDINGS ###

ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

ZVM_VI_HIGHLIGHT_BACKGROUND=none
ZVM_VI_HIGHLIGHT_FOREGROUND=none
ZVM_VI_HIGHLIGHT_EXTRASTYLE=none

zvm_after_init() {
    # Ctrl+\ -> toggle autosuggestions (useful for screen recordings)
    bindkey '^\' autosuggest-toggle
    
    # Rebind Ctrl+R to fzf history search in vi insert mode
    zvm_bindkey viins '^R' fzf-history-widget

    # Up/Down -> history search by substring (^[[A/^[[B are up/down arrow escape codes)
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
}

### PROMPT ###

eval "$(starship init zsh)"
