bindkey -v
bindkey -s '^o' 'yy^M'
bindkey -s '^e' 'toggle-venv^M'
bindkey '^j' history-search-forward
bindkey '^k' history-search-backward
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd '^e' edit-command-line
