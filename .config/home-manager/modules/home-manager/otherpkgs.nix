{
  pkgs,
  lib,
  ...
}:
{
  options.otherpkgs = lib.mkEnableOption "otherpkgs";
  config = {
    home.packages = with pkgs; [
      zathura
    ];
  };
}
