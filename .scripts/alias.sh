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


# rcp
alias ssh-rcp-zsh='ssh -t rcp-haas001 ". ~/.cargo/env; nix-user-chroot ~/.nix ~/.nix-profile/bin/zsh -l"'

# runai
alias ra='runai'
alias ral='runai list'
alias rali='runai-list-job-interactive'
alias rab='runai bash'
alias rabi='runai-bash-job-interactive'
alias radji='runai delete jobs $(rali)'
