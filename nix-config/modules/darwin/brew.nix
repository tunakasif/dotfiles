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
      "mas"
    ];
    casks = [
      # "adobe-acrobat-reader"
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
      "ghostty@tip"
      "google-chrome"
      "helium-browser"
      "insync"
      "kitty"
      "linear-linear"
      "notunes"
      "obs"
      "ollama-app"
      "orbstack"
      "protonvpn"
      "qbittorrent"
      "raycast"
      "skim"
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

    masApps = {
      "Keynote" = 409183694;
      "Numbers" = 409203825;
      "Pages" = 409201541;
      "iMovie" = 408981434;

      "Bitwarden" = 1352778147;
      "Dark Reader for Safari" = 1438243180;
      "Klack" = 6446206067;
      "SponsorBlock for Safari" = 1573461917;
    };
  };
}
