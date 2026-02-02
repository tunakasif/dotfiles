{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      dotDir = config.home.homeDirectory;

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
      initContent =
        let
          zshConfigEarlyInit = lib.mkOrder 500 ''
            ZSH_DISABLE_COMPFIX="true"
            export ZSH_COMPDUMP="${config.xdg.cacheHome}/zsh/zcompdump-${pkgs.zsh.version}"
            source "$HOME/dotfiles/.scripts/export.sh"
          '';
          zshConfig = lib.mkOrder 1000 ''
            source "$HOME/dotfiles/.scripts/alias.sh"
            source "$HOME/dotfiles/.scripts/functions.sh"
            source "$HOME/dotfiles/.scripts/phue.sh"
            source "$HOME/dotfiles/.scripts/kitty.sh"
            source "$HOME/dotfiles/.scripts/bindkey.sh"
            source "$HOME/dotfiles/.scripts/nix-brew-pathfix.sh"
            [ -f "$HOME/dotfiles/.scripts/secrets.sh" ] && source "$HOME/dotfiles/.scripts/secrets.sh"

            eval "$(starship init zsh)"
          '';
        in
        lib.mkMerge [
          zshConfigEarlyInit
          zshConfig
        ];
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    starship.enable = true;
    zoxide.enable = true;
  };

  home.activation.createZshCacheDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.xdg.cacheHome}/zsh"
  '';
}
