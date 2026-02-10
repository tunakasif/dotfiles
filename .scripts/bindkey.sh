bindkey -v
bindkey -s '^o' 'yy^M'
bindkey -s '^e' 'toggle-venv^M'
bindkey '^n' history-search-forward
bindkey '^p' history-search-backward
bindkey -M vicmd '^j' history-search-forward
bindkey -M vicmd '^k' history-search-backward
bindkey -M vicmd '^e' edit-command-line
