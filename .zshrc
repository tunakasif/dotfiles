source "$HOME/.scripts/export.sh"       
source "$HOME/.scripts/alias.sh"       

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
plugins=( git zsh-autosuggestions zsh-syntax-highlighting virtualenv poetry )
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh

# vi  mode
bindkey -v
export KEYTIMEOUT=1

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source "$HOME/.scripts/functions.sh"
source "$HOME/.scripts/phue.sh"
source "$HOME/.scripts/kitty.sh"

