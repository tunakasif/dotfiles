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
      cargo
      dust
      fd
      fzf
      gh
      go
      just
      lazygit
      nixfmt-rfc-style
      nodejs_24
      pandoc
      ripgrep
      ttyper
      uv
      yazi
    ];
  };
}
