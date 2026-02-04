{
  config,
  lib,
  ...
}:
let
    cfg = config.my.opencode;
in
{
  options.my.opencode = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable opencode configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.opencode = {
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
  };
}
