{
  pkgs,
  lib,
  config,
  ...
}: {
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
        plugins =
          [
            "docker"
            "git"
            "git-auto-fetch"
          ]
          # macOS uses its SSH agent; the GPG SSH-support probe is slow.
          ++ lib.optional (!pkgs.stdenv.hostPlatform.isDarwin) "gpg-agent"
          ++ ["keychain"];
        extraConfig = ''
          # Resolve symlinks so the unique fpath array removes duplicate directories.
          fpath=("''${(@)fpath:A}")

          zstyle :omz:plugins:keychain agents gpg,ssh
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=auto --group-directories-first --color=always $realpath'
        '';
      };

      plugins = [
        {
          name = "fzf-tab";
          src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
        }
      ];

      # Extra zshrc snippets
      initContent = let
        zshConfigEarlyInit = lib.mkOrder 500 ''
          # Homebrew exports FPATH; inherited plugin paths invalidate OMZ's cache.
          typeset +x FPATH
          # brew shellenv can be a no-op in nested shells, so add completions here too.
          if [[ -n "$HOMEBREW_PREFIX" ]]; then
            fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
          fi

          ZSH_DISABLE_COMPFIX="true"
          ZSH_COMPDUMP="${config.xdg.cacheHome}/zsh/zcompdump-$ZSH_VERSION"
          export GPG_TTY="$TTY"
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
        '';
      in
        lib.mkMerge [
          zshConfigEarlyInit
          zshConfig
        ];
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    starship.enable = true;
    zoxide.enable = true;
  };

  home.activation.createZshCacheDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${config.xdg.cacheHome}/zsh"
  '';
}
