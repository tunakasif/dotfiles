{
  pkgs,
  lib,
  ...
}:
{
  options.new = lib.mkEnableOption "new";
  config = {
    home.packages = with pkgs; [
      bat
      dust
      fd
      fzf
      gh
      just
      lazygit
      pandoc
      ttyper
      uv
      yazi
    ];
  };
}
