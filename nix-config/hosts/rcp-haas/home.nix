{
  pkgs,
  config,
  user,
  ...
}:
let
  organization = "lts4-dislearn";
  vscodeExtDir = "${config.home.homeDirectory}/.vscode/extensions";
in
{
  imports = [
    ../../modules/home-manager
  ];
  home = {
    username = user.gasparUsername;
    homeDirectory = "/home/${user.gasparUsername}";
    packages = with pkgs; [ hello ];

    # ~/.vscode-server/extensions (so point it at HM-managed extensions)
    file.".vscode-server/extensions".source = config.lib.file.mkOutOfStoreSymlink vscodeExtDir;
  };
  my.opencode.enable = false;
  programs = {
    zsh = {
      initContent = ''
        export SCRATCH_HOME=/mnt/${organization}/scratch/home/${user.gasparUsername}
        alias cdsh="cd $SCRATCH_HOME"
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
