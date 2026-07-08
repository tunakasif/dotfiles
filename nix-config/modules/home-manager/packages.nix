{
  pkgs,
  lib,
  inputs,
  ...
}: {
  config = {
    home.packages = with pkgs; [
      inputs.nix-auth.packages.${pkgs.stdenv.hostPlatform.system}.default
      act
      alejandra
      bat
      bibtex-tidy
      clang-tools
      cmatrix
      commitizen
      cookiecutter
      d2
      delta
      devenv
      doppler
      dust
      eza
      fastfetch
      fd
      # ffmpeg-full
      gdu
      gh
      ghostscript
      glab
      glow
      go
      gum
      hyperfine
      imagemagick
      jq
      jujutsu
      just
      kubernetes-helm
      lazydocker
      lazygit
      lazyjj
      less
      ltex-ls
      lua51Packages.luarocks
      lua5_1
      markdownlint-cli2
      marksman
      mermaid-cli
      nixfmt
      nmap
      nodejs_24
      openconnect
      pandoc
      pnpm
      pre-commit
      prettier
      prettierd
      ripgrep
      ruff
      scc
      speedtest-cli
      stylua
      taplo
      tealdeer
      tmux
      tree
      tree-sitter
      ttyper
      unzip
      uv
      watch
      wget
      yazi
      yt-dlp
      # zathura
      zsh-fzf-tab
    ];

    home.activation.uvPython = lib.hm.dag.entryAfter ["writeBoundary"] ''
      UV_PATH="/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin:$PATH"
      PATH="$UV_PATH" ${pkgs.uv}/bin/uv python install 3.11 3.12 3.13
      PATH="$UV_PATH" ${pkgs.uv}/bin/uv python pin --global 3.12
    '';
  };
}
