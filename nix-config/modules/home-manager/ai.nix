{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.my.ai;
  mkReasoningVariant = effort: {
    id = effort;
    settings.reasoningEffort = effort;
  };
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
            defaultProvider = "openai";
            defaultModel = "gpt-6-astra";
            defaultThinkingLevel = "xhigh";
            enabledModels = [
              "openai/gpt-6-astra"
              "openai/gpt-6.1-sol"
              "claude-bridge/claude-fable-5-1"
              "claude-bridge/claude-opus-5-5"
            ];
            packages = [
              "npm:pi-claude-bridge"
              "npm:pi-subagents"
              "npm:pi-messenger"
              "npm:pi-web-access"
              "npm:pi-lens"
              "npm:pi-footer"
              "npm:pi-btw"
              "npm:@upstash/context7-pi"
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
            tui = "fullscreen";
            includeCoAuthoredBy = false;
            model = "opus";
            effortLevel = "xhigh";
            modelSettings = {
              claude-opus-5-5 = {
                effortLevel = "xhigh";
              };
              claude-fable-5-1 = {
                effortLevel = "xhigh";
              };
            };
            permissions = {
              defaultMode = "auto";
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
          settings = {
            providers."epfl-rcp-aiaas" = {
              name = "RCP AI Inference as a Service";
              package = "aisdk:@ai-sdk/openai-compatible";
              settings.baseURL = "https://inference-rcp.epfl.ch/v1";
              models = {
                "epfl-aiaas/large" = {
                  name = "RCP AIaaS Large";
                  modelID = "epfl-aiaas/large";

                  capabilities = {
                    input = ["image" "text"];
                    output = ["text"];
                  };

                  cost = {
                    input = 0.1664;
                    output = 0.4991;
                    cache.read = 0.0166;
                  };

                  settings = {};
                };

                "epfl-aiaas/small" = {
                  name = "RCP AIaaS Small";
                  modelID = "epfl-aiaas/small";

                  capabilities = {
                    input = ["image" "text"];
                    output = ["text"];
                  };

                  cost = {
                    input = 0.1671;
                    output = 0.5014;
                    cache.read = 0.0167;
                  };

                  settings.reasoningEffort = "none";
                  variants = map mkReasoningVariant [
                    "none"
                    "low"
                    "high"
                    "xhigh"
                    "max"
                  ];
                };
              };
            };
          };
        };
      };
    })
  ];
}
