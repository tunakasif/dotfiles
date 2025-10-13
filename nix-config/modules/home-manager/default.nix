{ pkgs, ... }:
{
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
        "git-auto-fetch"
        "gpg-agent"
        "keychain"
        "z"
      ];
      extraConfig = ''
        zstyle :omz:plugins:keychain agents gpg,ssh
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=automatic --group-directories-first --color=always $realpath'
      '';

    };

    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];

    # Extra zshrc snippets
    initContent = ''
      bindkey -v
      export KEYTIMEOUT=1
      source "$HOME/dotfiles/.scripts/export.sh"
      source "$HOME/dotfiles/.scripts/alias.sh"
      source "$HOME/dotfiles/.scripts/functions.sh"
      source "$HOME/dotfiles/.scripts/phue.sh"
      source "$HOME/dotfiles/.scripts/kitty.sh"
      source "$HOME/dotfiles/.scripts/bindkey.sh"
      source "$HOME/dotfiles/.scripts/nix-brew-pathfix.sh"

      eval "$(starship init zsh)"
    '';
  };

  programs.btop.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.neovim.enable = true;
  programs.starship.enable = true;
  programs.zoxide.enable = true;

  # Individual imports
  imports = [
    ./new.nix
  ];
}
