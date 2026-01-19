{ pkgs, user, ... }:
let
  organization = "lts4-dislearn";
in
{
  imports = [
    ../../modules/home-manager
  ];
  home = {
    username = user.gaspar_username;
    homeDirectory = "/home/${user.gaspar_username}";
    packages = with pkgs; [ hello ];
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      charliermarsh.ruff
      editorconfig.editorconfig
      github.copilot
      github.copilot-chat
      ms-pyright.pyright
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

  programs.zsh = {
    initContent = ''
      export SCRATCH_HOME=/mnt/${organization}/scratch/home/${user.gaspar_username}
      alias cdsh="cd $SCRATCH_HOME"
    '';
  };
}
