{
  config,
  lib,
  ...
}: let
  cfg = config.my.ai;
in {
  options.my.ai = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Master switch for AI-related tools";
    };

    opencode = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = "Enable opencode configuration";
      };
    };

    claude = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = "Enable claude code configuration";
      };
    };

    codex = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = "Enable codex configuration";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.codex = {
        inherit (cfg.claude) enable;
      };

      programs.claude-code = {
        inherit (cfg.claude) enable;
        settings = {
          theme = "auto";
          includeCoAuthoredBy = false;
          model = "opus";
          permissions = {
            defaultMode = "acceptEdits";
            allow = [
              # Safe inspection
              "Bash(pwd)"
              "Bash(ls *)"
              "Bash(tree *)"
              "Bash(find *)"
              "Bash(fd *)"
              "Bash(rg *)"
              "Bash(grep *)"
              "Bash(cat *)"

              # Git read-only
              "Bash(git status *)"
              "Bash(git diff *)"
              "Bash(git log *)"
              "Bash(git branch *)"
              "Bash(git show *)"

              # Python project workflows
              "Bash(uv sync *)"
              "Bash(uv run *)"
              "Bash(pytest *)"
              "Bash(ruff check *)"
              "Bash(ruff format *)"
              "Bash(pyright *)"
            ];

            ask = [
              # Mutating VCS operations should stay visible.
              "Bash(git add *)"
              "Bash(git commit *)"
              "Bash(git push *)"
              "Bash(git reset *)"
              "Bash(git clean *)"

              # Package installs / external execution.
              "Bash(curl *)"
              "Bash(wget *)"
              "Bash(npm *)"
              "Bash(npx *)"
              "Bash(pip *)"
              "Bash(uv pip *)"
            ];

            deny = [
              # Secrets and credentials
              "Read(./.env)"
              "Read(./.env.*)"
              "Read(./secrets/**)"
              "Read(./.aws/**)"
              "Read(./.config/gh/hosts.yml)"
              "Read(./id_rsa)"
              "Read(./id_ed25519)"

              # Dangerous shell patterns
              "Bash(sudo *)"
              "Bash(su *)"
              "Bash(rm -rf / *)"
              "Bash(rm -rf ~ *)"
              "Bash(chmod 777 *)"
              "Bash(git push --force *)"
            ];
          };
        };
      };
      programs.opencode = {
        enable = cfg.opencode.enable;
        tui = {
          theme = "catppuccin";
        };
        settings = {
          provider = {
            cefprovider = {
              npm = "@ai-sdk/openai-compatible";
              name = "RCP AI Inference as a Service";
              options = {
                baseURL = "https://inference-rcp.epfl.ch/v1";
              };
              models = {
                "moonshotai/Kimi-K2.7-Code" = {
                  name = "moonshotai/Kimi-K2.7-Code";
                  modalities = {
                    input = ["image" "text"];
                    output = ["text"];
                  };
                };
              };
            };
          };
          plugin = [
            "opencode-claude-auth@latest"
          ];
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
