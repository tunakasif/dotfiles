{
  pkgs,
  user,
  config,
  ...
}:
{
  programs = {
    git = {
      enable = true;
      settings = {
        gpg.format = "ssh";
        tag.gpgsign = true;
        commit.gpgsign = true;
        user = {
          inherit (user) name email;
          signingkey = "${config.home.homeDirectory}/.ssh/id_rsa.pub";
        };
        init.defaultBranch = "main";
        push = {
          followTags = true;
          autoSetupRemote = true;
        };
        pull = {
          rebase = true;
        };
        fetch = {
          prune = true;
          pruneTags = true;
        };
      };
      ignores = [
        ".direnv/"
        ".DS_Store"
        "*.swp"
      ];
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      extensions = with pkgs; [
        gh-dash
        gh-f
      ];
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
