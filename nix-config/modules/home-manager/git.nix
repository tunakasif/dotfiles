{
  pkgs,
  user,
  config,
  ...
}:
{
  programs = {
    # Optional but nice: delta integration via HM module
    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    git = {
      enable = true;
      userName = user.name;
      userEmail = user.email;

      # Global ignores (like ~/.config/git/ignore)
      ignores = [
        ".direnv/"
        ".DS_Store"
        "*.swp"
      ];

      # Main gitconfig (writes to ~/.config/git/config)
      settings = {
        init.defaultBranch = "main";

        pull.rebase = true;
        fetch.prune = true;
        push.autoSetupRemote = true;

        core.editor = "nvim";

        # Commit signing example: SSH signing (popular alternative to GPG)
        gpg.format = "ssh";
        user.signingkey = "${config.home.homeDirectory}/.ssh/id_rsa.pub";
        commit.gpgsign = true;
        tag.gpgsign = true;
      };
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "https";
        prompt = "enabled";
      };
      gitCredentialHelper = {
        enable = true;
        hosts = [
          "https://github.com"
          "https://gist.github.com"
        ];
      };
      extensions = with pkgs; [
        gh-dash
        gh-f
      ];
    };
  };
}
