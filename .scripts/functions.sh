# functions
update_all () {
    figlet "dnf";
    sudo dnf upgrade -y;
    figlet "flatpak";
    flatpak update -y;
    figlet "snap";
    sudo snap refresh;
    figlet "brew";
    brew update && brew upgrade;
}

trash-can () {
  cd "$HOME/.local/share/Trash" || exit;
}

pytureng () {
  curr_path=$(pwd);
  cd "$HOME/Documents/GitHub/pytureng" || exit;
  poetry run python -m pytureng "$@";
  cd "$curr_path" || exit;
}

srs () {
  curr_path=$(pwd);
  cd "$HOME/Documents/GitHub/BilBot" || exit;
  poetry run python bilkent_bot.py;
  cd "$curr_path" || exit;
}

airs () {
  curr_path=$(pwd);
  cd "$HOME/Documents/GitHub/BilBot" || exit;
  poetry run python bilkent_bot.py --site airs;
  cd "$curr_path" || exit;
}

ytd () {
    yt-dlp -f $YT_DLP_FORMAT $1;
}

ytfzfd () {
    yt-dlp -f "$YT_DLP_FORMAT" "$(ytfzf -tL $1)";
}


mine_eth_tmux() {
  curr_path=$(pwd)
  location=$HOME/Programs/lolMiner/1.36a;
  cd $location || exit;
  tmux new -d -s eth_miner './mine_eth.sh';
  cd $curr_path || exit;
}

mine_eth() {
  location=$HOME/Programs/lolMiner/1.36a;
  cd $location || exit;
  ./mine_eth.sh;
}

my_mail() {
  mw -Y;
  neomutt;
}

brightness() {
    xrandr --output DP-0 --brightness $1
}

kitty_force_ssh() {
    infocmp -a xterm-kitty | ssh $1 tic -x -o \~/.terminfo /dev/stdin
}

kitty_update() {
    # Update kitty
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    # Icon paths
    icon_path="$HOME/.local/kitty.app/share/icons"
    repo_name="kitty-icon"
    dinkdonk_path="${icon_path}/DinkDonk/${repo_name}"
    k0nserv_path="${icon_path}/k0nserv/${repo_name}"
    mkdir -pv $dinkdonk_path
    mkdir -pv $k0nserv_path

    # Download icon repos
    dinkdonk_repo="https://github.com/DinkDonk/kitty-icon.git"
    k0nserv_repo="https://github.com/k0nserv/kitty-icon.git"
    git clone $dinkdonk_repo $dinkdonk_path
    git clone $k0nserv_repo $k0nserv_path
}

compress_pdf() {
    dir_name="$(dirname $1)";
    file_name="$(basename $1)";
    out_file_name="compressed_$file_name";
    out_file_path="$dir_name/$out_file_name";
    gs -sDEVICE=pdfwrite -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$out_file_path $1
}

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir" || exit
            fi
        fi
    fi
}

wifi_pass() {
    nmcli device wifi show-password
}

kittytrans() {
    kitty @set-background-opacity "${1:-0.7}";
}

bw_unlock() {
    session="$(bw unlock $(pass bitwarden) | grep export | awk -F '"' '{print $2}')";
    export BW_SESSION="$session";
}

glint() {
    # check if a `.gitlint` config file exists in the directory,
    # if not, use the default config file provided in the dotfiles
    # repo. If even the repo does not exist, then use the without
    # config file option.
    default_config_file="$HOME/dotfiles/.gitlint";
    if [ ! -f "$default_config_file" ] || [ -f ".gitlint" ]; then
        gitlint "$@";
    else
        gitlint --config "$default_config_file" "$@";
    fi
}
