{
  pkgs,
  user,
  inputs,
  ...
}:
let
  uid = 501; # User ID created by MacOS for the user use `id -u` to get it.
in
{
  ids.gids.nixbld = 350;
  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 4;

  security.pam.services.sudo_local = {
    reattach = true; # fixes Touch ID not working inside tmux
    touchIdAuth = true;
    watchIdAuth = true;
  };
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

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
    onActivation = {
      cleanup = "zap"; # Remove all Homebrew packages not in the flake
      autoUpdate = true;
      upgrade = true;
    };
    global.brewfile = true;
    caskArgs.no_quarantine = true;

    taps = [ ];
    brews = [
      "asitop"
      "bitwarden-cli"
      "graphviz"
    ];
    casks = [
      "appcleaner"
      "arc"
      "bitwarden"
      "brave-browser"
      "calibre"
      "chatgpt"
      "discord"
      "firefox"
      "ghostty"
      "google-chrome"
      "insync"
      "kitty"
      "obs"
      "ollama-app"
      "orbstack"
      "protonvpn"
      "qbittorrent"
      "raycast"
      "slack"
      "spotify"
      "tiles"
      "visual-studio-code"
      "vlc"
      "whatsapp"
      "zen"
      "zotero"
      "zoom"
    ];
  };
}
