# setup homebrew
export PATH=$PATH:/opt/homebrew/bin
eval "$(/opt/homebrew/bin/brew shellenv)"

set -o vi

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

# setup cargo
. "$HOME/.cargo/env"

# setup gcc
alias gcc="gcc-14"
alias g++="g++-14"

# setup java
export JAVA_HOME="/opt/homebrew/opt/openjdk"

# setup python
alias python3="/opt/homebrew/bin/python3"

# setup golang
export GOPATH=$HOME/Developer/go
export GOBIN=$GOPATH/bin
export PATH="$PATH:${GOBIN}:${GOROOT}/bin"

# setup nvim
alias vi=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export CPATH="$CPATH:/opt/homebrew/Cellar/raylib/5.0/include/"

# setup exa
alias ls="eza --group-directories-first --color=always"
alias la="eza -lah --group-directories-first --color=always"

# pnpm
export PNPM_HOME="/Users/ketan/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# gem
export GEM_HOME=$HOME/.gem/ruby/2.6.0
export PATH=$GEM_HOME/bin:$PATH

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# setup chromium
export PATH="$PATH:$HOME/Developer/github.com/google/depot_tools"

# doom emacs
export PATH=$PATH:$HOME/.config/emacs/bin

# fzf setup
eval "$(fzf --bash)"
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"
export FZF_DEFAULT_COMMAND="fd --type f"

export PATH=$PATH:/opt/homebrew/Cellar/llvm/18.1.8/bin

# tomcat
export CATALINA_BASE=$(brew --prefix tomcat)/libexec
export CATALINA_HOME=$(brew --prefix tomcat)/libexec

# foundry
export PATH="$PATH:/Users/ketan/.foundry/bin"

export PATH="/opt/homebrew/opt/ffmpeg@6/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ffmpeg@6/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ffmpeg@6/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ffmpeg@6/lib/pkgconfig"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[ -f /Users/ketan/.dart-cli-completion/bash-config.bash ] && . /Users/ketan/.dart-cli-completion/bash-config.bash || true
## [/Completion]

