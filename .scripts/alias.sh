# system stuff
alias up="sudo dnf upgrade"
alias upy="sudo dnf upgrade -y"

# neovim stuff
alias e="nvim"
alias c="code"

# directory stuff
alias cdd="cd $HOME/Desktop"
alias cdgh="cd $HOME/repos"
alias cddf="cd $HOME/repos/dotfiles"
alias cdre="cd $HOME/GDrive/school/PhD/research"
alias cdcc="cd $HOME/GDrive/school/PhD/courses"
alias xo="xdg-open"

# config stuff
alias vimconfig="$EDITOR $HOME/.vimrc"
alias nvimconfig="$EDITOR $HOME/.config/nvim/"

# kitty stuff
alias icat='kitty +kitten icat'
alias kittyconfig="$EDITOR $HOME/.config/kitty/kitty.conf"

# eza
alias ls='eza'
alias ll='eza --icons --long --group-directories-first --git'
alias llgi='eza --icons --long --group-directories-first --git --git-ignore'
alias la='eza --icons --all --long --group-directories-first --git'
alias lagi='eza --icons --all --long --group-directories-first --git --git-ignore'

# cli ai stuff
alias ghs="gh copilot suggest"
