{
  pkgs,
  user,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  networking = {
    hostName = user.mediaServerName;
    networkmanager.enable = true;
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xserver.xkb = {
      layout = "tr";
      variant = "";
      options = "caps:escape";
    };

    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings.main.capslock = "escape";
      };
    };
  };
  console.keyMap = "trq";
  security.rtkit.enable = true;

  users.users.${user.username} = {
    isNormalUser = true;
    description = user.name;
    extraGroups = ["networkmanager" "wheel"];
  };

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    claude-code
    gh
    git
    neovim
    pi-coding-agent
    thunderbird
    vim
    wget
  ];

  system.stateVersion = "26.05";
}
