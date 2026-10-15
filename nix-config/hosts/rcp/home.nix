{
  pkgs,
  config,
  user,
  lib,
  ...
}: let
  organization = "lts4-dislearn";
  vscodeExtDir = "${config.home.homeDirectory}/.vscode/extensions";
  claudeSettings = builtins.toJSON {
    hasCompletedOnboarding = true;
    theme = "auto";
  };
in {
  imports = [
    ../../modules/home-manager
  ];
  home = {
    username = user.gasparUsername;
    homeDirectory = "/home/${user.gasparUsername}";
    packages = with pkgs; [
      inotify-tools
      doppler
    ];

    # ~/.vscode-server/extensions (so point it at HM-managed extensions)
    file.".vscode-server/extensions".source = config.lib.file.mkOutOfStoreSymlink vscodeExtDir;

    # init claude settings
    activation.seedClaudeSettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
            file="$HOME/.claude.json"

            if [ ! -e "$file" ]; then
              cat > "$file" <<'EOF'
      ${claudeSettings}
      EOF
              chmod u+rw "$file"
            fi
    '';
    activation.settingsDetach = lib.hm.dag.entryAfter ["linkGeneration"] ''
      targets=(
        "$HOME/.claude/settings.json"
        "$HOME/.config/gh/config.yml"
      )

      for target in "''${targets[@]}"; do
        if [ -L "$target" ]; then
          real="$(readlink -f "$target")" # resolve to the /nix/store file
          run rm -f "$target"
          run install -m644 "$real" "$target"
        fi
      done
    '';
  };
  my = {
    latex = "medium";
  };
  programs = {
    direnv.config.whitelist.prefix = ["/"];
    zsh = {
      initContent = ''
        export SHELL="$HOME/.nix-profile/bin/zsh"
        export SCRATCH_HOME=/mnt/${organization}/scratch/home/${user.gasparUsername}
        export _ZO_DATA_DIR=/mnt/${organization}/scratch/home/${user.gasparUsername}/.local/share/zoxide/

        alias cdsh="cd $SCRATCH_HOME"

        watch-credentials() {
            local file="$1" secret="$2" changed

            inotifywait -m -q -e close_write,moved_to --format '%w%f' "$(dirname "$file")" |
            while IFS= read -r changed; do
            [[ "$changed" == "$file" && -s "$file" ]] || continue

            doppler secrets set "$secret" \
                --no-check-version \
                --project dotfiles \
                --config dev \
                --type json \
                --silent < "$file"
            done
        }
      '';
    };
    git.settings = {
      safe = {
        directory = "*";
      };
    };
    vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        charliermarsh.ruff
        editorconfig.editorconfig
        github.copilot
        github.copilot-chat
        ms-python.debugpy
        ms-python.mypy-type-checker
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.vscode-remote-extensionpack
        njpwerner.autodocstring
        tamasfe.even-better-toml
        yzhang.markdown-all-in-one
      ];
    };
  };
}
