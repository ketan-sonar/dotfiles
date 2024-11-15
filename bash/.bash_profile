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

export PS1="\[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

export PATH="`brew --prefix gcc`/bin:$PATH"
alias gcc="gcc-14"

alias ls="ls --color=always --group-directories-first"
alias la="ls --color=always -lah --group-directories-first"
alias vi="nvim"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[ -f /Users/ketan/.dart-cli-completion/bash-config.bash ] && . /Users/ketan/.dart-cli-completion/bash-config.bash || true
## [/Completion]

export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

source /opt/homebrew/opt/rustup/etc/bash_completion.d/rustup
source /opt/homebrew/etc/bash_completion.d/fnm
source /opt/homebrew/etc/bash_completion.d/forge
source /opt/homebrew/etc/bash_completion.d/anvil
source /opt/homebrew/etc/bash_completion.d/cast

eval "$(fnm env --use-on-cd --shell bash)"

export GOPATH="$HOME/Developer/go"

export PATH="$PATH:/Users/ketan/.foundry/bin"
export PATH="$PATH:$HOME/Developer/github.com/ketan-sonar/brightme"
