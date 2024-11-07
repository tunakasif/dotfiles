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
