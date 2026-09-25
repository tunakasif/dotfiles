{
  config,
  lib,
  ...
}: let
  cfg = config.my.yt-dlp;
in {
  options.my.yt-dlp = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Controls whether the yt-dlp configuration is enabled.";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.yt-dlp = {
        inherit (cfg) enable;
        settings = {
          downloader = "aria2c";
          downloader-args = "aria2c:'-c -j 4 -x 16 -s 16 -k 1M --file-allocation=none'";
          embed-subs = true;
          sub-langs = "all";
        };
      };
    })
  ];
}
