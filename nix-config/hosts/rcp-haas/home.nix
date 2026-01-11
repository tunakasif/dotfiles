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
  programs.zsh = {
    initContent = ''
      export SCRATCH_HOME=/mnt/${organization}/scratch/home/${user.gaspar_username}
      alias cdsh="cd $SCRATCH_HOME"
    '';
  };
}
