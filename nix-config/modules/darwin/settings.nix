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
      };
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = false;
        _FXSortFoldersFirst = true;
        _FXSortFoldersFirstOnDesktop = true;
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
