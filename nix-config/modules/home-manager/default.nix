{
  ...
}:
{
  home.stateVersion = "25.11";
  xdg.enable = true;
  programs = {
    home-manager.enable = true;
    neovim.enable = true;
    zathura.enable = true;
  };

  imports = [
    ./shell.nix
    ./btop.nix
    ./packages.nix
    ./rust.nix
    ./git.nix
    ./ai.nix
  ];
}
