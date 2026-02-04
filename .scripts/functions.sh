# functions
update-all() {
    if type dnf &>/dev/null; then
        figlet "dnf"
        sudo dnf upgrade -y
    fi
    if type flatpak &>/dev/null; then
        figlet "flatpak"
        flatpak update -y
    fi
    if type snap &>/dev/null; then
        figlet "snap"
        sudo snap refresh
    fi
    if type brew &>/dev/null; then
        figlet "brew"
        brew update && brew upgrade
    fi
}

cds() {
    if [ -z "$1" ]; then
        cd "$HOME" || return
    elif [[ -d $1 ]]; then
        cd "$1" || return
    elif [[ -f $1 ]]; then
        cd "$(dirname "$1")" || return
    else
        cd "$@" || return
    fi
}

trash-can() {
    cd "$HOME/.local/share/Trash" || exit
}

ytd() {
    yt-dlp -f $YT_DLP_FORMAT $1
}

ytfzfd() {
    yt-dlp -f "$YT_DLP_FORMAT" "$(ytfzf -tL $1)"
}

my-mail() {
    mw -Y
    neomutt
}

brightness() {
    xrandr --output DP-0 --brightness $1
}

kitty-force-ssh() {
    infocmp -a xterm-kitty | ssh $1 tic -x -o \~/.terminfo /dev/stdin
}

kitty-update() {
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

compress-pdf() {
    dir_name="$(dirname $1)"
    file_name="$(basename $1)"
    out_file_name="compressed_$file_name"
    out_file_path="$dir_name/$out_file_name"
    gs -sDEVICE=pdfwrite -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$out_file_path $1
}

lfcd() {
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

wifi-pass() {
    nmcli device wifi show-password
}

kittytrans() {
    kitty @set-background-opacity "${1:-0.7}"
}

bw-unlock() {
    session="$(bw unlock $(doppler secrets get --plain BITWARDEN_PASSWORD) | grep export | awk -F '"' '{print $2}')"
    export BW_SESSION="$session"
}

epfl-vpn() {
    vpn_url="vpn.epfl.ch"
    vpn_user="tuna.alikasifoglu@epfl.ch"

    echo "Unlocking BitWarden session ..."
    current_bw_session="$(echo $BW_SESSION)"
    export BW_SESSION="$(bw unlock $(doppler secrets get --plain BITWARDEN_PASSWORD) | grep export | awk -F '"' '{print $2}')"

    echo "Retrieving VPN credentials ..."
    vpn_password="$(doppler secrets get EPFL_PASSWORD --plain)"
    vpn_totp="$(bw get totp 'EPFL Microsoft')"

    echo "Connecting to EPFL VPN ..."
    echo "$vpn_password\n$vpn_totp\n" | sudo openconnect $vpn_url --user $vpn_user --passwd-on-stdin
    export BW_SESSION="$current_bw_session"
}

lintgit() {
    # check if a `.gitlint` config file exists in the directory,
    # if not, use the default config file provided in the dotfiles
    # repo. If even the repo does not exist, then use the without
    # config file option.
    default_config_file="$HOME/dotfiles/.gitlint"
    if [ ! -f "$default_config_file" ] || [ -f ".gitlint" ]; then
        gitlint "$@"
    else
        gitlint --config "$default_config_file" "$@"
    fi
}

kill-wp() {
    wp_pids="$(pidof whatsapp-desktop-linux)"

    if [ -n "$wp_pids" ]; then
        echo "$wp_pids" | xargs kill
    else
        echo "No whatsapp-desktop-linux process found"
    fi
}

rte() {
    rustureng_exe="$HOME/repos/rustureng/target/release/rustureng"
    if [ ! -f "$rustureng_exe" ]; then
        echo "rustureng executable does not exist"
        return
    fi

    content="$($rustureng_exe "$@")"
    echo $content | less -F
}

install-nerd-font() {
    # list all the nerd fonts available in the latest release
    # Use GitHub CLI to get the `*.zip` files in the latest release.
    # The use `fzf` to provide an interactive interface for selecting.
    selected_font="$(gh release view --json assets \
        --jq '.assets[] | select(.contentType == "application/zip") | .name' \
        -R ryanoasis/nerd-fonts | awk -F . '{print $1}' | fzf)"

    # download the nerd font
    zip_file="$selected_font.zip"
    gh release download -p "$zip_file" -R ryanoasis/nerd-fonts
    echo "Download complete."

    # extract `*.ttf` files to `~/.local/share/fonts` and delete the zip file
    echo "Extracting fonts ..."
    unzip -o "$zip_file" "*.ttf" -d "$HOME/.local/share/fonts"
    rm "$zip_file"
}

gitignore-download() {
    TREE_BASE_URL="https://api.github.com/repos/github/gitignore/git/trees/main"
    DOWNLOAD_BASE_URL="https://raw.githubusercontent.com/github/gitignore/main"

    name=$(
        curl --silent $TREE_BASE_URL |
            jq '.tree[].path' |                  # get the name of `.gitignore` files
            sed 's/"//g' |                       # remove the quotes
            awk '/\.gitignore$/ { print }' |     # select only the `.gitignore` files
            awk -F '.gitignore' '{ print $1 }' | # remove the `.gitignore` extension
            fzf                                  # interactive interface for selecting
    )
    if [[ -n "$name" ]]; then
        curl --silent --url "$DOWNLOAD_BASE_URL/$name.gitignore" >>.gitignore
    fi
}

get-mtype-lang-file() {
    TREE_BASE_URL="https://api.github.com/repos/monkeytypegame/monkeytype/git/trees/master?recursive=1"
    DOWNLOAD_BASE_URL="https://raw.githubusercontent.com/monkeytypegame/monkeytype/master"

    name=$(
        curl --silent $TREE_BASE_URL |
            jq '.tree[].path' |                                  # get the path of all files
            sed 's/"//g' |                                       # remove the quotes
            awk '/^frontend\/static\/languages\// { print }' |   # select languages
            awk -F 'frontend/static/languages/' '{ print $2 }' | # remove prefix
            awk '/\.json$/ { print }' |                          # select only the `.json` files
            awk -F '.json' '{ print $1 }' |                      # remove the `.json` extension
            awk '!/^_/ { print }' |                              # ignore the ones that start with `_`
            fzf                                                  # interactive interface for selecting
    )
    target_url="$DOWNLOAD_BASE_URL/frontend/static/languages/$name.json"
    words=$(curl --silent $target_url | jq '.words[]' | sed 's/"//g')
    tmpfile=$(mktemp)
    echo $words | tr ' ' '\n' >$tmpfile
    echo $tmpfile
}

function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

function toggle-venv() {
    if [[ -z "$VIRTUAL_ENV" ]]; then
        # If not in a virtual environment, check if the activate script exists
        if [[ -f ".venv/bin/activate" ]]; then
            source .venv/bin/activate
            echo "Activated virtual environment."
        else
            echo "Error: .venv/bin/activate not found. Please create a virtual environment."
        fi
    else
        # If in a virtual environment, deactivate it
        deactivate
        echo "Deactivated virtual environment."
    fi
}

function unique-extentions() {
    fd -t file . | awk -F '.' '{print $NF}' | sort | uniq
}

function gh-clone-interactive() {
    username="$(gh api /user | jq -r '.login')"
    orgs="$(gh api /user/orgs | jq -r '.[].login' | sort)"
    owner="$(printf '%s\n%s' "$username" "$orgs" | gum choose)"
    if [[ -z "$owner" ]]; then
        return 1
    fi
    repo=$(gh repo list -L 10000 --json name,description,visibility,updatedAt "$owner" |
        jq -r '.[] | [
            .name,
            .description,
            (.visibility | ascii_downcase),
            (.updatedAt | fromdate | localtime | strftime("%Y-%m-%d %H:%M:%S"))
        ] | @csv' |
        gum table -c "Name,Description,Visibility,Last Updated" -w 20,60,15,25 | cut -d ',' -f 1)
    if [[ -z "$repo" ]]; then
        return 1
    fi
    gum confirm "Clone $owner/$repo to $(pwd)?" || return 1
    gh repo clone "$owner/$repo"
}

function docker-clean-none() {
    docker images | grep none | awk '{print $3}' | xargs docker rmi -f
}

function docker-pull-interactive() {
    for image in $(docker images --format '{{.Repository}}:{{.Tag}}' | sort | gum choose --no-limit); do
        echo "Pulling $image ..."
        docker pull "$image"
        echo
    done
}

function runai-list-job-interactive() {
    runai list jobs | fzf --header-lines=2 | awk '{print $1}'
}

function runai-bash-job-interactive() {
    job_id=$(runai-list-job-interactive)
    runai bash "$job_id"
}

function rcp-nix-shell() {
    pod_info="$(kubectl get pod)"
    header="$(echo "$pod_info" | head -n 1)"
    pods="$(echo "$pod_info" | tail -n +2)"
    if [ -z "$pods" ]; then
        echo "No pods found."
        return 1
    fi
    selected_pod="$(echo $pods | sed 's/ /\t/g' | gum filter --header="$header" --select-if-one | awk '{print $1}')"
    kubectl exec --stdin --tty $selected_pod -- /home/$EPFL_USER/.nix-profile/bin/zsh -l
}

function ocrun() {
    PROVIDER='opencode'

    # model selection
    model_list=$(opencode models $PROVIDER | awk -F "$PROVIDER/" '{print $2}')
    selected_model="$(gum filter --placeholder "Select a model" <<<"$model_list")"
    if [ -z "$selected_model" ]; then # if no model is selected, exit
        return 1
    fi

    # variant selection
    escaped=$(echo "$PROVIDER/$selected_model" | sed 's/\//\\\//g')
    beginning='print "$&\n" while /'
    end='\s*(\{(?:[^{}]|(?1))*\})/gs'

    verbose_model_output=$(opencode models opencode --verbose | perl -0777 -ne "$beginning$escaped$end")
    variants=$(echo "$verbose_model_output" | tail -n +2 | jq -r '.variants | keys[]')

    if [ -z "$variants" ]; then
        selected_variant="default"
    else
        # if response is negative, set variant to default with gum confirm
        if ! gum confirm "Do you want to select a variant for $selected_model?" --default=No; then
            selected_variant="default"
        else
            selected_variant="$(gum filter --placeholder "Select a variant for $selected_model" <<<$variants)"
            if [ -z "$selected_variant" ]; then
                return 1
            fi
        fi
    fi

    # run
    gum log -l info "using model: $PROVIDER/$selected_model (variant: $selected_variant)"
    opencode run \
        --model "$PROVIDER/$selected_model" \
        --variant "$selected_variant" \
        "$(gum write --placeholder 'Enter your prompt...')" |
        glow -
}
