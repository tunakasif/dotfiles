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

    pcscd.enable = true;
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
    shell = pkgs.zsh;
  };

  programs = {
    firefox.enable = true;
    nix-ld.enable = true;
    zsh.enable = true;
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-gnome3;
      };
    };
  };
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    claude-code
    gcc
    gh
    gnumake
    gnupg
    git
    neovim
    pi-coding-agent
    thunderbird
    tree-sitter
    vim
    vscode
    wget
  ];

  system.stateVersion = "26.05";
}
