{
  pkgs,
  user,
  inputs,
  ...
}:
let
  systemApps = "/System/Applications";
  userApps = "/Applications";
in
{
  ids.gids.nixbld = 350;
  nix.settings.experimental-features = "nix-command flakes";

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    stateVersion = 4;
    primaryUser = user.username;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      iCal."first day of week" = "Monday";
      LaunchServices.LSQuarantine = false; # disable quarantine for downloaded applications
      dock = {
        autohide = true;
        tilesize = 70;
        largesize = 80;
        magnification = true;
        launchanim = true;
        mineffect = "genie";
        orientation = "bottom";
        show-process-indicators = true;
        show-recents = false;
        mru-spaces = false;
        persistent-apps = [
          { app = "${systemApps}/System Settings.app"; }
          { app = "${userApps}/kitty.app"; }
          { app = "${userApps}/Helium.app"; }
          { app = "${systemApps}/Mail.app"; }
          { app = "${userApps}/Visual Studio Code.app"; }
          { app = "${systemApps}/Calendar.app"; }
          { app = "${userApps}/Slack.app"; }
          { app = "${userApps}/zoom.us.app"; }
          { app = "${userApps}/Spotify.app"; }
          { app = "${userApps}/WhatsApp.app"; }
          { app = "${systemApps}/Messages.app"; }
          { app = "${systemApps}/FaceTime.app"; }
          { app = "${userApps}/Zotero.app"; }
          { app = "${systemApps}/iPhone Mirroring.app"; }
        ];
        # disable hot corners
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = false;
        _FXSortFoldersFirst = true;
        _FXSortFoldersFirstOnDesktop = true;
      };
      trackpad = {
        Clicking = true;
        TrackpadCornerSecondaryClick = 2; # bottom right corner
      };
      menuExtraClock = {
        ShowDate = 0; # when space allows
        Show24Hour = true;
      };
    };
  };

  security.pam.services.sudo_local = {
    reattach = true; # fixes Touch ID not working inside tmux
    touchIdAuth = true;
    watchIdAuth = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
}
