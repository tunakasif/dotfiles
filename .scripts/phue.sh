phue() {
    curr_path=$(pwd);
    cd $HOME/Documents/GitHub/phue_control;
    poetry run python3 -m phue_control set-scene-by-name "$1";
    cd "$curr_path";
}
