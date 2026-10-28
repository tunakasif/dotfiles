{
  pkgs,
  user,
  ...
}: let
  organization = "lts4-dislearn";
in {
  imports = [
    ../../modules/home-manager
  ];
  home = {
    username = user.gasparUsername;
    homeDirectory = "/home/${user.gasparUsername}";
    packages = with pkgs; [
      claude-code
      codex
      doppler
      opencode
      pi-coding-agent
    ];
  };
  my = {
    ai.enabled = false;
    latex = "medium";
  };
  programs = {
    codex.settings.cli_auth_credentials_store = "file";
    direnv.config.whitelist.prefix = ["/"];
    zsh = {
      initContent = ''
        export SHELL="$HOME/.nix-profile/bin/zsh"
        export SCRATCH_HOME=/mnt/${organization}/scratch/home/${user.gasparUsername}
        export _ZO_DATA_DIR=/mnt/${organization}/scratch/home/${user.gasparUsername}/.local/share/zoxide/

        alias cdsh="cd $SCRATCH_HOME"
      '';
    };
    git.settings = {
      safe = {
        directory = "*";
      };
    };
  };
}
