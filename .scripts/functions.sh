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
  cd "/home/tunakasif/.local/share/Trash";
}

srs () {
  curr_path=$(pwd);
  cd ~/Documents/GitHub/BilBot;
  poertry run python bilkent_bot.py;
  cd "$curr_path";
}

airs () {
  curr_path=$(pwd);
  cd ~/Documents/GitHub/BilBot;
  poertry run python bilkent_bot.py --site airs;
  cd "$curr_path";
}

ytd () {
    yt-dlp -f $YT_DLP_FORMAT $1;
}

ytfzfd () {
    yt-dlp -f $YT_DLP_FORMAT $(ytfzf -tL $1);
}


mine_eth_tmux() {
  curr_path=$(pwd)
  location=$HOME/Programs/lolMiner/1.36a;
  cd $location;
  tmux new -d -s eth_miner './mine_eth.sh';
  cd $curr_path;
}

mine_eth() {
  location=$HOME/Programs/lolMiner/1.36a;
  cd $location;
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

wifi_pass(){
    network_path="/etc/NetworkManager/system-connections/";
    lenght=${#network_path};
    text="$(sudo grep -r '^psk=' $network_path)";
    path_removed="$(echo $text | awk -F "${network_path}" '{print $2}')";
    wifis="$(echo $path_removed | awk -F '.' '{print $1}')";
    passwd="$(echo $path_removed | awk -F '=' '{print $2}')";

    echo $path_removed;
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
                cd "$dir"
            fi
        fi
    fi
}

