{
  pkgs,
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

    pi = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = "Enable pi configuration";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      xdg.configFile."ponytail/config.json".text = builtins.toJSON {defaultMode = "off";};
      home.file."${config.programs.pi-coding-agent.configDir}/claude-bridge.json".text = builtins.toJSON {
        provider = {
          plan = "max";
          pathToClaudeCodeExecutable = lib.getExe pkgs.claude-code;
        };
        askClaude.enabled = false;
        startupNoticeShown = "2026-09-25";
      };
      programs = {
        pi-coding-agent = {
          inherit (cfg.pi) enable;
          extraPackages = [pkgs.nodejs];
          settings = {
            defaultProvider = "openai-codex";
            defaultModel = "gpt-6-astra";
            defaultThinkingLevel = "xhigh";
            enabledModels = [
              "openai-codex/gpt-6-astra"
              "claude-bridge/claude-fable-5-1"
              "claude-bridge/claude-opus-5"
            ];
            packages = [
              "npm:pi-claude-bridge"
              "npm:pi-subagents"
              "npm:pi-messenger"
              "npm:pi-web-access"
              "npm:pi-mcp-adapter"
              "npm:pi-lens"
              "npm:pi-footer"
              "npm:pi-btw"
              "npm:@juicesharp/rpiv-todo"
              "npm:@juicesharp/rpiv-ask-user-question"
              "npm:@dietrichgebert/ponytail"
              "npm:@sherif-fanous/pi-catppuccin"
            ];
            theme = "catppuccin-mocha";
            enableInstallTelemetry = false;
          };
        };

        codex = {
          inherit (cfg.codex) enable;
        };

        claude-code = {
          inherit (cfg.claude) enable;
          settings = {
            extraKnownMarketplaces.ponytail = {
              source = {
                source = "github";
                repo = "DietrichGebert/ponytail";
              };
              autoUpdate = true;
            };
            enabledPlugins = {
              "ponytail@ponytail" = true;
            };
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
        opencode = {
          inherit (cfg.opencode) enable;
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
                    cost = {
                      input = 0.4771;
                      output = 1.4312;
                    };
                    limit = {
                      context = 200000;
                      output = 50000;
                    };
                  };
                  "deepseek-ai/DeepSeek-V4-Flash-0731" = {
                    name = "deepseek-ai/DeepSeek-V4-Flash-0731";
                    modalities = {
                      input = ["text"];
                      output = ["text"];
                    };
                    cost = {
                      input = 0.0824;
                      output = 0.2473;
                    };
                    limit = {
                      context = 900000;
                      output = 100000;
                    };
                    reasoning = true;
                    options = {
                      reasoning_effort = "max";
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
      };
    })
  ];
}
