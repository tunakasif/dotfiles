inputs: {
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  xdg.enable = true;

  # Individual imports
  imports = [
    ./new.nix
  ];
}
