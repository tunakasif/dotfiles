{user, ...}: {
  imports = [
    ../../modules/home-manager
  ];

  home = {
    inherit (user) username;
    homeDirectory = "/home/${user.username}";
  };
}
