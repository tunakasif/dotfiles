{
  lib,
  config,
  pkgs,
  user,
  ...
}: let
  claudeSettingsPath = "${config.programs.claude-code.configDir}/settings.json";
in {
  imports = [
    ../../modules/home-manager
  ];
  my = {
    latex = "full";
  };
  home = {
    inherit (user) username;
    homeDirectory = "/Users/${user.username}";
    packages = with pkgs; [hello];

    file.${claudeSettingsPath}.force = lib.mkForce true;
    activation.claudeSettingsDetach = lib.hm.dag.entryAfter ["linkGeneration"] ''
      run mkdir -p "$HOME/.claude"
      target="$HOME/.claude/settings.json"
      if [ -L "$target" ]; then
        real="$(readlink -f "$target")" # resolve to the /nix/store file
        run rm -f "$target"
        run install -m 0600 "$real" "$target"
      fi
    '';
  };
}
