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

  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.watchIdAuth = true;
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

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
    onActivation.cleanup = "zap"; # Remove all Homebrew packages not in the flake
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    taps = [ ];
    brews = [ ];
    casks = [
      "slack"
      "spotify"
      "tiles"
      "visual-studio-code"
      "whatsapp"
      "zen"
      "zotero"
    ];
  };
}
