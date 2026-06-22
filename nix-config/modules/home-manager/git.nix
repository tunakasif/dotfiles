{
  pkgs,
  user,
  config,
  ...
}: {
  programs = {
    jujutsu = {
      enable = true;
      settings = {
        user = {
          inherit (user) name email;
        };
      };
    };
    git = {
      enable = true;
      settings = {
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
        };
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
          ff = "only";
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
