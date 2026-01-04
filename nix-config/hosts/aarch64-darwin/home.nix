{ pkgs, user, ... }:
{
  imports = [
    ../../modules/home-manager
  ];
  home = {
    inherit (user) username;
    homeDirectory = "/Users/${user.username}";
    packages = with pkgs; [ hello ];
  };
}
