{ pkgs, user, ... }:
{
  imports = [
    ../../modules/home-manager
  ];
  home = {
    username = user.username;
    homeDirectory = "/Users/${user.username}";
    packages = with pkgs; [ hello ];
  };
  gum.enable = false;
  mypkgs.enable = false;
}
