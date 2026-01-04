{ user, ... }:
let
  uid = 501; # User ID created by MacOS for the user use `id -u` to get it.
in
{
  imports = [
    ../../modules/darwin
  ];

  # Host-specific user configuration
  users = {
    knownUsers = [ user.username ];
    users.${user.username} = {
      name = user.username;
      description = user.name;
      home = "/Users/${user.username}";
      inherit uid;
    };
  };
}
