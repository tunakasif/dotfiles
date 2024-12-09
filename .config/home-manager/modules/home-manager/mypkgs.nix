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
      lf
      ltex-ls
      marksman
      nixfmt-rfc-style
      poetry
      ruff
      slides
      stylua
      taplo
      texliveFull
      ttyper
      typst
      typst-lsp
      uv
      wishlist
      yazi
    ];
  };
}
