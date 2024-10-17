{ pkgs, user, ... }:
{
  imports = [
    ../../modules/home-manager
  ];
  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    packages = with pkgs; [ hello ];
  };
  gum.enable = true;
  mypkgs.enable = true;
}
