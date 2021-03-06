dotfiles="$HOME/dotfiles"
export PATH="\
$dotfiles/bin:\
/usr/local/bin:\
$HOME/.local/bin:\
$dotfiles/bin:\
/usr/local/bin:\
$PATH\
"

export CELLAR='/usr/local/Cellar/'

# export MANPATH="/usr/local/man:$MANPATH"

# virtualenvwrapper
export WORKON_HOME="$HOME/virtualenvs"
source '/usr/local/bin/virtualenvwrapper.sh'
export VIRTUALENVWRAPPER_PYTHON=$(which python3)

# exports
export bin="$dotfiles/bin/"
export config="$HOME/.config/"
export vimrc="$config/nvim/init.vim"
export VISUAL=vim

fpath=($fpath $dotfiles/pure)

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

# User configurationw
bindkey -v
bindkey '^R' history-incremental-search-backward

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# aliases
alias zshrc="vi $zshrc"
alias vimrc='vi ~/.config/nvim/init.vim'
alias xinitrc="vi ~/.xinitrc"
alias sovim='source ~/.vimrc'
alias bundles='vi ~/dotfiles/nvim/vimrc.bundles'
alias ignore-untracked="git status --porcelain | grep '^??' | cut -c4- >> .gitignore"
alias install-tensorflow="pip install --upgrade $TF_BINARY_URL"
alias commit="git commit -am $@"
alias i3config="vi ~/.config/i3/config"
alias vi=nvim
alias ls='ls --color'
alias pacman='sudo pacman'
alias wifi='sudo wifi-menu'

# pretty vi
#source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

# pure
autoload -U promptinit; promptinit
prompt pure

# zsh syntax highlighting
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# source z
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

setopt autocd
setopt autopushd
setopt inc_append_history
setopt inc_append_history
setopt share_history

# History
setopt APPEND_HISTORY          # append rather than overwrite history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information
HISTFILE=$HOME/.zhistory       # enable history saving on shell exit
HISTSIZE=1200                  # lines of history to maintain memory
SAVEHIST=1000                  # lines of history to maintain in history file.

autoload zmv
autoload -U compinit
compinit

# Go
export GOPATH=~/go
PATH=$PATH:$GOPATH/bin



# added by travis gem
[ -f /home/ethanbro/.travis/travis.sh ] && source /home/ethanbro/.travis/travis.sh

# save last visited dir
export CURRENT_PROJECT_PATH=$HOME/.current-project
function current {
  if [[ -f $CURRENT_PROJECT_PATH  ]]; then
    cd "$(cat $CURRENT_PROJECT_PATH)"
  fi
}
current
function wtf { 
  local args 
  args="$@" 
  ipython --pdb -c "%run $args"
}
