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

pytureng() {
	curr_path=$(pwd)
	cd "$HOME/Documents/GitHub/pytureng" || exit
	poetry run python -m pytureng "$@"
	cd "$curr_path" || exit
}

srs() {
	curr_path=$(pwd)
	cd "$HOME/Documents/GitHub/BilBot" || exit
	poetry run python bilkent_bot.py
	cd "$curr_path" || exit
}

airs() {
	curr_path=$(pwd)
	cd "$HOME/Documents/GitHub/BilBot" || exit
	poetry run python bilkent_bot.py --site airs
	cd "$curr_path" || exit
}

ytd() {
	yt-dlp -f $YT_DLP_FORMAT $1
}

ytfzfd() {
	yt-dlp -f "$YT_DLP_FORMAT" "$(ytfzf -tL $1)"
}

mine-eth-tmux() {
	curr_path=$(pwd)
	location=$HOME/Programs/lolMiner/1.36a
	cd $location || exit
	tmux new -d -s eth_miner './mine_eth.sh'
	cd $curr_path || exit
}

mine-eth() {
	location=$HOME/Programs/lolMiner/1.36a
	cd $location || exit
	./mine_eth.sh
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
	session="$(bw unlock $(pass bitwarden) | grep export | awk -F '"' '{print $2}')"
	export BW_SESSION="$session"
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
	rustureng_exe="$HOME/Documents/GitHub/rustureng/target/release/rustureng"
	if [ ! -f "$rustureng_exe" ]; then
		echo "rustureng executable does not exist"
		return
	fi

	content="$($rustureng_exe "$@")"
	echo $content | $PAGER -F
}

push-nvim-plugin-update() {
	cwd=$(pwd)
	cd "$HOME/.config/nvim" || return
	git diff --quiet lazy-lock.json && cd "$cwd" && return
	git add "lazy-lock.json"
	git commit -m 'chore(nvim): update `nvim` plugins' -m 'Update Neovim plugins.'
	git push
	cd "$cwd" || return
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
		curl $TREE_BASE_URL |
			jq '.tree[].path' |                  # get the name of `.gitignore` files
			sed 's/"//g' |                       # remove the quotes
			awk '/\.gitignore$/ { print }' |     # select only the `.gitignore` files
			awk -F '.gitignore' '{ print $1 }' | # remove the `.gitignore` extension
			fzf                                  # interactive interface for selecting
	)
	curl --url "$DOWNLOAD_BASE_URL/$name.gitignore" >>.gitignore
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

switch-cuda() {
	set -e

	INSTALL_FOLDER="/usr/local"
	TARGET_VERSION=${1}

	if [[ -z ${TARGET_VERSION} ]]; then
		echo "The following CUDA installations have been found (in '${INSTALL_FOLDER}'):"
		find "${INSTALL_FOLDER}/" -maxdepth 1 -name '*cuda-[0-9]*' | while read -r line; do
			echo "- ${line}"
		done
		set +e
		return
	elif [[ ! -d "${INSTALL_FOLDER}/cuda-${TARGET_VERSION}" ]]; then
		echo "No installation of CUDA ${TARGET_VERSION} has been found!"
		set +e
		return
	fi

	cuda_path="${INSTALL_FOLDER}/cuda-${TARGET_VERSION}"
	new_path=$(echo "$PATH" | awk -v RS=: '!/cuda/' ORS=:)
	new_path="${cuda_path}/bin:${new_path}"

	new_ld_path=$(echo "$LD_LIBRARY_PATH" | awk -v RS=: '!/cuda/' ORS=:)
	new_ld_path="${cuda_path}/lib64:${cuda_path}/extras/CUPTI/lib64:${new_ld_path}"

	export CUDA_HOME="${cuda_path}"
	export CUDA_ROOT="${cuda_path}"
	export LD_LIBRARY_PATH="${new_ld_path}"
	export PATH="${new_path}"

	echo "Switched to CUDA ${TARGET_VERSION}."

	set +e
}
