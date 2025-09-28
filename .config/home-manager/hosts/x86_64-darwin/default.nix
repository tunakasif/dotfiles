{
  pkgs,
  user,
  inputs,
  ...
}:
let
  uid = 502; # User ID created by MacOS for the user use `id -u` to get it.
in
{
  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 4;
  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.watchIdAuth = true;
  programs.zsh.enable = true;

  system.primaryUser = "tunakasif";
  users.knownUsers = [ user.username ];
  users.users.${user.username} = {
    name = user.username;
    description = user.name;
    home = "/Users/${user.username}";
    uid = uid;
  };

  homebrew = {
    enable = true;
    # onActivation.cleanup = "zap"; # Remove all Homebrew packages not in the flake
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    taps = [
      "charmbracelet/tap"
      "d99kris/nchat"
      "dopplerhq/cli"
    ];
    brews = [
      "act"
      "bat"
      "btop"
      "cmatrix"
      "commitizen"
      "cookiecutter"
      "doppler"
      "eza"
      "fastfetch"
      "fd"
      "figlet"
      "fzf"
      "gh"
      "git"
      "git-delta"
      "gitlint"
      "glow"
      "hyperfine"
      "jq"
      "julia"
      "just"
      "lolcat"
      "make"
      "markdownlint-cli2"
      "nchat"
      "neomutt"
      "newsboat"
      "pandoc"
      "pnpm"
      "pre-commit"
      "ripgrep"
      "sqlmap"
      "starship"
      "tealdeer"
      "tmux"
      "vhs"
      "wget"
    ];
    casks = [
      "anydesk"
      "arc"
      "brave-browser"
      "calibre"
      "discord"
      "docker"
      "docker-desktop"
      "firefox"
      "font-academicons"
      "font-caskaydia-cove-nerd-font"
      "font-caskaydia-mono-nerd-font"
      "font-consolas-for-powerline"
      "font-devicons"
      "font-fira-code-nerd-font"
      "font-material-icons"
      "ghostty"
      "github"
      "kitty"
      "obs"
      "protonvpn"
      "qbittorrent"
      "raycast"
      "slack"
      "spotify"
      "vlc"
      "warp"
      "whatsapp"
      "zen"
      "zotero"
    ];
  };
}
