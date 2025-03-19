{
  pkgs,
  lib,
  ...
}:
{
  options.mypkgs = lib.mkEnableOption "mypkgs";
  config = {
    home.packages = with pkgs; [
      act
      age
      bat
      bitwarden-cli
      cookiecutter
      dust
      fd
      lazygit
      lf
      ltex-ls
      marksman
      nixfmt-rfc-style
      pandoc
      poetry
      rclone
      ruff
      rustscan
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
