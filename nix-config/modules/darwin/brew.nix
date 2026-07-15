_: {
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap"; # Remove all Homebrew packages not in the flake
      upgrade = true;
    };
    global = {
      autoUpdate = true;
      brewfile = true;
    };

    taps = [];
    brews = [
      "asitop"
      "bitwarden-cli"
      "gnupg"
      "graphviz"
      "terminal-notifier"
    ];
    casks = [
      "adobe-acrobat-reader"
      "appcleaner"
      "arc"
      "brave-browser"
      "calibre"
      "chatgpt"
      "claude"
      "cursor"
      "discord"
      "firefox"
      "ghostty"
      "google-chrome"
      "helium-browser"
      "insync"
      "kitty"
      "latexit"
      "logi-options+"
      "monitorcontrol"
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
      "thunderbird"
      "telegram"
      "tiles"
      "visual-studio-code"
      "vlc"
      "wealthfolio"
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
