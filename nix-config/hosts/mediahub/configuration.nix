{
  pkgs,
  user,
  ...
}: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  networking = {
    hostName = user.mediaServerName;
    networkmanager.enable = true;
    firewall.extraCommands = ''
      iptables -A nixos-fw -s 192.168.1.0/24 -p tcp --dport 22 -j nixos-fw-accept
    '';
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.nvidia = {
    # The Pascal GTX 1050 Ti requires the closed kernel module and 580 legacy branch.
    branch = "legacy_580";
    open = false;
    # Keep the desktop on Intel; FFmpeg accesses NVIDIA directly through CUDA/NVENC.
    prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services = {
    openssh = {
      enable = true;
      openFirewall = false;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [user.username];
      };
    };
    displayManager.gdm = {
      enable = true;
      autoSuspend = false;
    };
    desktopManager.gnome.enable = true;
    logind.settings.Login = {
      IdleAction = "ignore";
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
    };
    xserver = {
      videoDrivers = ["nvidia"];
      xkb = {
        layout = "tr";
        variant = "";
        options = "caps:escape";
      };
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
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7i6tFgftK8ibglU2kUm9VLvecBjJLBraPvwJncxpWg/xfkc1vs8tpslcaOL9W1duVGRfsUU4kIn9PR+aMgqzj24WdFPPCg1V8SazAgvHWAcaw1xA+5wupQntRT8JLeqgAyfLuYmouqYmt9IrfHnIO6zJetc0wSn3Z2DXsJNfsFntKQH/X2V6L80AKOQ26obexYtT0LocMQMa3KSuZo8SswF5hPQgh8/pplPm8dC8NLVzk7u9Bz1ZMjsNOIL4t0bEGI/1tb4Rxx9Z9IeZOQxJqAKBtU6Rgvz8jgOglM35jUGbzO6m4zwNFnl7eo5ReQemlZ07YK50e/pQVFJPHxpx2fRzT1j+rERKnPC9Fy6ZNKBMD642zMBwqluqtnYG96ZE5RFfkmSQRLQT37c6j2qSCKtHPYAqdRdC0V3+JuuvHNBv0Dlz5Ko1PRWhaCtTiJ8WnyuqzaMvzHo+qSBi28UNziuylu8shAlhFoRubPALqRc15wy4pgwVhJhN7p1Ec/tk= tunakasif@gmail.com"
    ];
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

  xdg.terminal-exec = {
    enable = true;
    settings.default = ["kitty.desktop"];
  };
  environment.sessionVariables.TERMINAL = "kitty";

  environment.systemPackages = with pkgs; [
    claude-code
    gcc
    gh
    git
    gnumake
    gnupg
    kitty
    neovim
    pi-coding-agent
    thunderbird
    tree-sitter
    vim
    vscode
    wget
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  virtualisation.docker.enable = true;
  system.stateVersion = "26.05";
}
