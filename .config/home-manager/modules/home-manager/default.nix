inputs: {
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  xdg.enable = true;

  # Individual imports
  imports = [
    ./gum.nix
    ./mypkgs.nix
  ];
}
