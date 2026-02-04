{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my;
in
{
  options.my = {
    latex = lib.mkOption {
      type = lib.types.enum [
        "disabled"
        "medium"
        "full"
      ];
      default = "disabled";
      description = "LaTeX installation: disabled, medium, or full";
    };
  };

  config = lib.mkIf (cfg.latex != "disabled") {
    home.packages = with pkgs; [
      (if cfg.latex == "full" then texliveFull else texliveMedium)
    ];
  };
}
