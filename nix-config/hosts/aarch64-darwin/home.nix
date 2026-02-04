{ pkgs, user, ... }:
{
  imports = [
    ../../modules/home-manager
  ];
  my = {
    latex = "full";
  };

  home = {
    inherit (user) username;
    homeDirectory = "/Users/${user.username}";
    packages = with pkgs; [ hello ];
  };
}
