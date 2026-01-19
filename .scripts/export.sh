export EDITOR="nvim"
export VISUAL="nvim"
export TERM=xterm-256color
export YT_DLP_FORMAT='bestvideo[height<=?1440][vcodec!=?vp9]+bestaudio/best'
export FZF_DEFAULT_OPTS="--layout=reverse \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export DISABLE_UPDATE_PROMPT=true # disable oh-my-zsh update prompt
export CALIBRE_LIBRARY="$HOME/GDrive/AppSync/Calibre"
export KEYTIMEOUT=1 # for vi mode

# PATH
export PATH="$PATH:/usr/local/bin:/usr/local/go/bin:$HOME/.local/bin:$HOME/bin:$HOME/go/bin"

# Fedora flags
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

# MATLAB (sometimes necessary for Linux)
# export LD_LIBRARY_PATH="usr/local/MATLAB/R2021a/bin/glnxa64/:$LD_LIBRARY_PATH"

# ZSH Plugins
export _Z_EXCLUDE_DIRS="$HOME/Videos"
typeset -ga ZSHZ_EXCLUDE_DIRS=("$HOME/Videos")

# CUDA
export PATH="$PATH:/usr/local/cuda/bin"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

export COOKIECUTTER_CONFIG=$HOME/dotfiles/.config/cookieconfig.yaml

# runai
export SUPPRESS_DEPRECATION_MESSAGE=true
