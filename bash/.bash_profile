eval "$(/opt/homebrew/bin/brew shellenv)"

set -o vi

# default ubuntu prompt
# export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# export PS1='${debian_chroot:+($debian_chroot)}[\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]]\$ '

function parse_git_dirty {
    [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}

# PROMPT_COMMAND='RET_CODE=$?'
PROMPT_COMMAND='RET_CODE=0'

# export PS1="\033[31m$(if [ -n "$RET_CODE" ] && [ $RET_CODE -ne 0 ]; then echo "$RET_CODE "; fi)\[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
export PS1="\[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[0m\] \[\033[31m\]\$(if [ \$RET_CODE -ne 0 ]; then echo \$RET_CODE '' ; fi)\[\033[0m\]\$ "

export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

export PATH="`brew --prefix gcc`/bin:$PATH"
alias gcc="gcc-14"

alias ls="ls --color=always --group-directories-first"
alias la="ls --color=always -lah --group-directories-first"
alias vi="nvim"

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[ -f /Users/ketan/.dart-cli-completion/bash-config.bash ] && . /Users/ketan/.dart-cli-completion/bash-config.bash || true
## [/Completion]

[[ -r $FVM_DIR/bash_completion ]] && \. $FVM_DIR/bash_completion

eval "$(fnm env --use-on-cd --shell bash)"

export DEV_DIR="$HOME/Developer"

export GOPATH="$DEV_DIR/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

export PATH="$PATH:/Users/ketan/.foundry/bin"
export PATH="$PATH:$DEV_DIR/github.com/ketan-sonar/brightme"

export MANPAGER="nvim +Man!"

export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH="$JAVA_HOME/bin:$PATH"
export CPPFLAGS="-I@JAVA_HOME/include"

export PATH="/Users/ketan/.local/share/solana/install/active_release/bin:$PATH"

export PATH="~/.cargo/bin:$PATH"
. "$HOME/.cargo/env"

export PATH="/Users/ketan/.local/share/solana/install/active_release/bin:$PATH"
