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
        mcp = {
          filesystem = {
            enabled = true;
            type = "local";
            command = [
              "npx"
              "-y"
              "@modelcontextprotocol/server-filesystem"
              "."
            ];
          };
          fetch = {
            enabled = true;
            type = "local";
            command = [
              "uvx"
              "mcp-server-fetch"
            ];
          };
          git = {
            enabled = true;
            type = "local";
            command = [
              "uvx"
              "mcp-server-git"
            ];
          };
          rg = {
            enabled = true;
            type = "local";
            command = [
              "npx"
              "-y"
              "mcp-ripgrep"
            ];
          };
          pdf-reader = {
            enabled = false;
            type = "local";
            command = [
              "npx"
              "-y"
              "@sylphx/pdf-reader-mcp"
            ];
          };
        };
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
