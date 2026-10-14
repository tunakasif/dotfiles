{pkgs, ...}: {
  home.stateVersion = "26.11";
  xdg.enable = true;
  programs = {
    home-manager.enable = true;
    neovim = {
      enable = true;
      sideloadInitLua = true;
      withPython3 = true;
      extraPython3Packages = ps: [ps.jupyter-client];
      extraPackages = [pkgs.imagemagick];
    };
    # zathura.enable = true;
  };

  imports = [
    ./shell.nix
    ./btop.nix
    ./packages.nix
    ./rust.nix
    ./git.nix
    ./ai.nix
    ./latex.nix
    ./yt-dlp.nix
  ];
}
