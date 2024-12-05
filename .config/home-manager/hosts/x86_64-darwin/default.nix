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
  services.nix-daemon.enable = true;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 5;
  security.pam.enableSudoTouchIdAuth = true;
  programs.zsh.enable = true;

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
    ];
    brews = [
      "act"
      "bat"
      "btop"
      "cmatrix"
      "commitizen"
      "cookiecutter"
      "eza"
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
      "lazygit"
      "lolcat"
      "make"
      "markdownlint-cli2"
      "neofetch"
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
      "brave-browser"
      "calibre"
      "discord"
      "docker"
      "firefox"
      "font-academicons"
      "font-caskaydia-cove-nerd-font"
      "font-caskaydia-mono-nerd-font"
      "font-consolas-for-powerline"
      "font-devicons"
      "font-fira-code-nerd-font"
      "font-material-icons"
      "github"
      "kitty"
      "obs"
      "ollama"
      "protonvpn"
      "qbittorrent"
      "raycast"
      "spotify"
      "vlc"
      "warp"
      "whatsapp"
      "zen-browser"
    ];
  };
}
