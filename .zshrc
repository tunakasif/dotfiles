source "$HOME/.scripts/export.sh"       
source "$HOME/.scripts/alias.sh"       

plugins=( 
    extract
    fzf-zsh-plugin
    gh
    git
    poetry
    virtualenv
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-interactive-cd
    zsh-syntax-highlighting
    zsh-z
)
source $ZSH/oh-my-zsh.sh

# vi  mode
bindkey -v
export KEYTIMEOUT=1

source "$HOME/.scripts/functions.sh"
source "$HOME/.scripts/phue.sh"
source "$HOME/.scripts/kitty.sh"

bindkey -s '^o' 'lfcd^M'
bindkey -s '^e' 'nvim .^M'
bindkey -s '^b' 'code .^M'
bindkey '^j' history-substring-search-down
bindkey '^k' history-substring-search-up 

eval $(thefuck --alias)
eval $(starship init zsh)
