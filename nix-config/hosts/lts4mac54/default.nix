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

  homebrew.casks = [
    "insta360-link-controller"
  ];

  # Register the nix-maintained zsh as a valid login shell.
  environment.shells = [pkgs.zsh];
  environment.variables = {
    NODE_EXTRA_CA_CERTS = "/etc/ssl/cert.pem";
  };

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
