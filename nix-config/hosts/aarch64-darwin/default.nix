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
  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    stateVersion = 4;
    primaryUser = user.username;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
  users = {
    knownUsers = [ user.username ];
    users.${user.username} = {
      name = user.username;
      description = user.name;
      home = "/Users/${user.username}";
      inherit uid;
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
