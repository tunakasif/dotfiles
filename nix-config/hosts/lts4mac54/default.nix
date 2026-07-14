{
  pkgs,
  user,
  ...
}: let
  uid = 501; # User ID created by MacOS for the user use `id -u` to get it.
in {
  imports = [
    ../../modules/darwin
  ];

  # Register the nix-maintained zsh as a valid login shell.
  environment.shells = [pkgs.zsh];

  # Host-specific user configuration
  users = {
    knownUsers = [user.username];
    users.${user.username} = {
      name = user.username;
      description = user.name;
      home = "/Users/${user.username}";
      shell = pkgs.zsh;
      inherit uid;
    };
  };
}
