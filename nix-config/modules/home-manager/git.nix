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
        merge = {
          conflictStyle = "zdiff3";
        };
        diff.tool = "difftastic";
        difftool.difftastic.cmd = ''${config.programs.difftastic.package}/bin/difft "$LOCAL" "$REMOTE"'';
        alias = {
          # Structural diffs with difftastic
          ddiff = "-c diff.external=difft diff";
          dshow = "-c diff.external=difft show --ext-diff";
          dlog = "-c diff.external=difft log -p --ext-diff";
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
      options = {
        navigate = true;
        line-numbers = true;
      };
    };

    difftastic = {
      enable = true;
      options = {
        color = "always";
        sort-paths = true;
        tab-width = 4;
      };
    };
  };
}
