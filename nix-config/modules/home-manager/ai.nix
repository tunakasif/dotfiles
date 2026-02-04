{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.ai;
in
{
  options.my.ai = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Master switch for AI-related tools";
    };

    crush = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = "Enable crush AI tool";
      };
    };

    opencode = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = "Enable opencode configuration";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.crush.enable {
      home.packages = with pkgs; [
        crush
      ];
    })

    (lib.mkIf cfg.opencode.enable {
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
    })
  ];
}
