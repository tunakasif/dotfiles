phue() {
    scene="$1"
    scene_lower="$(echo "$scene" | tr '[:upper:]' '[:lower:]')"
    curr_path=$(pwd);
    cd $HOME/Documents/GitHub/phue_control;
    if [[ "$scene_lower" = "off"  ]]; then
       poetry run python3 -m phue_control switch all off;
    else
        poetry run python3 -m phue_control set-scene-by-name "$scene";
    fi
    cd "$curr_path";
}
