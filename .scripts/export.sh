export EDITOR="$(which nvim)"
# export VISUAL="nvr --remote-wait +'set bufhidden=wipe'"
export BROWSER="firefox"
export TERM=xterm-256color
export YT_DLP_FORMAT='bestvideo[height<=?1440][vcodec!=?vp9]+bestaudio/best'
export FZF_DEFAULT_OPTS='--layout=reverse'
export ZSH="$HOME/.oh-my-zsh"
export DISABLE_UPDATE_PROMPT=true # disable oh-my-zsh update prompt
export CALIBRE_LIBRARY="$HOME/Drive/AppSync/Calibre"
export KEYTIMEOUT=1 # for vi mode

# PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
export PATH=$HOME/.emacs.d/bin:$PATH
export PATH=$HOME/.emacs.d/bin:$PATH

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
export _Z_EXCLUDE_DIRS="$HOME/Videos/"

# CUDA
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
