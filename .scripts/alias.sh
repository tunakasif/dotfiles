# system stuff
alias up="sudo dnf upgrade"
alias upy="sudo dnf upgrade -y"
alias please='sudo $(fc -ln -1)'

# neovim stuff
alias e="nvim"
alias c="code"

# directory stuff
alias cdd="cd $HOME/Desktop"
alias cdgh="cd $HOME/Documents/GitHub"
alias cdve="cd $HOME/.cache/pypoetry/virtualenvs"
alias cddf="cd $HOME/Documents/GitHub/dotfiles"
alias cdhue="cd $HOME/Documents/GitHub/phue_control"
alias cdre="cd $HOME/Drive/school/MS/research"
alias cdcc="cd $HOME/Drive/school/MS/current"
alias fml='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias xo="xdg-open"
alias lnwd='ln -s "$(pwd -P)"'

# dictionary stuff
alias dict_eng_tur="dict -d fd-eng-tur"
alias dict_tur_eng="dict -d fd-tur-eng"

# config stuff
alias vimconfig="$EDITOR $HOME/.vimrc"
alias nvimconfig="$EDITOR $HOME/.config/nvim/"
alias zshconfig="$EDITOR $HOME/.zshrc; source $HOME/.zshrc"
alias ohmyzsh="$EDITOR $HOME/.oh-my-zsh"

# kitty stuff
alias icat='kitty +kitten icat'
alias kittyconfig="$EDITOR $HOME/.config/kitty/kitty.conf"

# exa
alias ls='exa'
alias ll='exa --icons --long --group-directories-first --git'
alias llgi='exa --icons --long --group-directories-first --git --git-ignore'
alias la='exa --icons --all --long --group-directories-first --git'
alias lagi='exa --icons --all --long --group-directories-first --git --git-ignore'
