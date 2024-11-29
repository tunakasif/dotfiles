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
      dust
      lf
      ltex-ls
      marksman
      nixfmt-rfc-style
      poetry
      slides
      stylua
      taplo
      ttyper
      typst
      typst-lsp
      uv
      wishlist
      yazi
    ];
  };
}
