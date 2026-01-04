{
  ...
}:
{
  home.stateVersion = "25.11";
  xdg.enable = true;
  programs = {
    home-manager.enable = true;
    neovim.enable = true;
    opencode = {
      enable = true;
      settings = {
        theme = "catppuccin";
      };
    };
    zathura.enable = true;
  };

  imports = [
    ./shell.nix
    ./btop.nix
    ./packages.nix
    ./git.nix
  ];
}
