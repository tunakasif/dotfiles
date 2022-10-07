source "$HOME/.scripts/export.sh"       
source "$HOME/.scripts/alias.sh"       

plugins=(
    alias-tips
    fzf
    fzf-tab
    gh
    git
    git-auto-fetch
    poetry
    virtualenv
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

source "$HOME/.scripts/functions.sh"
source "$HOME/.scripts/phue.sh"
source "$HOME/.scripts/kitty.sh"
source "$HOME/.scripts/bindkey.sh"

bindkey -s '^b' 'code .^M'
bindkey '^j' history-substring-search-down
bindkey '^k' history-substring-search-up 

# eval
eval $(thefuck --alias)
eval "$(starship init zsh)"

