_: {
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
      "gnupg"
      "graphviz"
    ];
    casks = [
      "adobe-acrobat-reader"
      "appcleaner"
      "arc"
      "antigravity"
      "bitwarden"
      "brave-browser"
      "calibre"
      "chatgpt"
      "cursor"
      "discord"
      "firefox"
      "ghostty"
      "google-chrome"
      "helium-browser"
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
      "zoom"
      "zotero"
    ];
  };
}
