{
  lib,
  user,
  ...
}: {
  services = {
    jellyfin = {
      enable = true;
      group = "media";
    };
    radarr = {
      enable = true;
      group = "media";
    };
    sonarr = {
      enable = true;
      group = "media";
    };
    prowlarr.enable = true;
    flaresolverr.enable = true;
    qbittorrent = {
      enable = true;
      group = "media";
      webuiPort = 8080;
      extraArgs = ["--confirm-legal-notice"];
      # Leave serverConfig unset: it overwrites Web UI settings on every start.
    };
  };

  users.groups.media = {};
  users.users.${user.username}.extraGroups = ["media"];

  systemd.tmpfiles.rules = [
    "d /srv/media 2770 ${user.username} media -"
    "d /srv/media/movies 2770 ${user.username} media -"
    "d /srv/media/tv 2770 ${user.username} media -"
    "d /srv/media/downloads 2770 ${user.username} media -"
    "d /srv/media/downloads/incomplete 2770 ${user.username} media -"
    "d /srv/media/downloads/movies 2770 ${user.username} media -"
    "d /srv/media/downloads/tv 2770 ${user.username} media -"
  ];
  systemd.services = {
    radarr.serviceConfig.UMask = lib.mkForce "0007";
    sonarr.serviceConfig.UMask = lib.mkForce "0007";
    qbittorrent.serviceConfig.UMask = "0007";
  };

  # Keep web UIs and Jellyfin discovery on the LAN, not globally open.
  networking.firewall.extraCommands = ''
    iptables -A nixos-fw -s 192.168.1.0/24 -p tcp -m multiport --dports 8096,7878,8989,9696,8080 -j nixos-fw-accept
    iptables -A nixos-fw -s 192.168.1.0/24 -p udp --dport 7359 -j nixos-fw-accept
  '';
}
