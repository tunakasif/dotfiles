{
  pkgs,
  user,
  ...
}: let
  organization = "lts4-dislearn";
  haasHome = "haas-home";
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
      t3code
    ];
  };
  my = {
    ai.enable = false;
    latex = "medium";
  };
  programs = {
    codex.settings.cli_auth_credentials_store = "file";
    direnv.config.whitelist.prefix = ["/"];
    zsh = {
      initContent = ''
        export SHELL="$HOME/.nix-profile/bin/zsh"
        export HAAS_HOME=/mnt/${haasHome}
        export SCRATCH_HOME=/mnt/${organization}/scratch/home/${user.gasparUsername}
        export _ZO_DATA_DIR=/mnt/${organization}/scratch/home/${user.gasparUsername}/.local/share/zoxide/
        export T3_HOME=$SCRATCH_HOME/.t3-rcp

        alias cdsh="cd $SCRATCH_HOME"
        alias t3-serve="t3 serve --host 127.0.0.1 --port 3773 --base-dir $T3_HOME"
      '';
    };
    git.settings = {
      safe = {
        directory = "*";
      };
    };
  };
}
