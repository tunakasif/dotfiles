inputs: {
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  xdg.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;

    # Oh My Zsh
    oh-my-zsh = {
      enable = true;
      plugins = [
        "docker"
        "fzf"
        "git"
      ];
      # You can also add your own plugins by dropping files under ~/.config/zsh or with home.file (see below)
    };

    # Extra zshrc snippets
    initContent = ''
      export EDITOR=nvim

      alias ll="ls -lah"
      alias gs="git status"
    '';
  };

  programs.neovim = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
  };

  # Individual imports
  imports = [
    ./new.nix
  ];
}
