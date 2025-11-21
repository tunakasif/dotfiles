{ pkgs, user, ... }:
{
  imports = [
    ../../modules/home-manager
  ];
  home = {
    username = user.gaspar_username;
    homeDirectory = "/home/${user.gaspar_username}";
    packages = with pkgs; [ hello ];
  };
}
