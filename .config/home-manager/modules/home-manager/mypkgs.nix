{
  pkgs,
  lib,
  ...
}:
{
  options.mypkgs = lib.mkEnableOption "mypkgs";
  config = {
    home.packages = with pkgs; [
      age
      bat
      dust
      fd
      lazygit
      lf
      ltex-ls
      marksman
      nixfmt-rfc-style
      poetry
      rclone
      ruff
      slides
      stylua
      taplo
      texliveFull
      ttyper
      typst
      uv
      wishlist
      yazi
    ];
  };
}
