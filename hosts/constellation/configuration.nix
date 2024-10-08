{ nixpkgs, pkgs, ... }: {
  imports = [ 
    ./hardware-configuration.nix
    ./networking.nix
    ../../programs/non-free.nix
    ../../programs/nixarr/nixarr.nix
    ../../programs/qbitrr/qbitrr.nix
    ];

  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        zfsSupport = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    initrd.kernelModules = [
      "zfs"
      "i915"
    ];
    kernelPackages = pkgs.linuxPackages_6_10;
    supportedFilesystems = [ "zfs" ];
    zfs.extraPools = [ "datapool" ];
    kernel.sysctl = {
      "vm.swappiness" = 180;
    };
  };


  services.zfs.autoScrub.enable = true;

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  time.timeZone = "America/New_York";

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };


  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  hardware.enableRedistributableFirmware = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver vaapiVdpau libvdpau-va-gl ];
  };

  hardware.pulseaudio = {
    package = pkgs.pulseaudioFull;
    extraConfig = ''
    load-module module-udev-detect ignore_dB=1
    load-module module-detect
    load-module module-alsa-card device_id="sofhdadsp" tsched=0
    load-module module-alsa-source device_id="sofhdadsp"
    load-module module-alsa-sink device_id="sofhdadsp"
    set-card-profile alsa_card.sofhdadsp output:analog-stereo+input:analog-stereo
    set-default-sink alsa_output.sofhdadsp.analog-stereo
    options snd_hda_intel power_save=0
  '';
  };

  environment.variables = {
    VDPAU_DRIVER = "va_gl";
    LIBVA_DRIVER_NAME = "iHD";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  users.groups = {
    media = { };
  };
  programs.fish.enable = true;
  users.users.dylan = {
    isNormalUser = true;
    createHome = true;
    group = "users";
    extraGroups =
      [ "wheel" "networkmanager" "docker" "media" ];
    home = "/home/dylan";
    uid = 1000;
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWcrem5HETpI7+g+oSKLKkQzKkoA6Rgbcd9bFIlNdAv"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0GBuGcyaeLluRP0S+hzVaImcK8ZdhHAPK8kYnY+5ff"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKB466E68pNKhuPLCW+KXJzKUzi7N1qHjS+1kZIlIa9b"
    ];
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    nixPath = [ "nixpkgs=${nixpkgs}" ];
    registry.nixpkgs.flake = nixpkgs;
    package = pkgs.nixVersions.latest;
    settings = {
      substituters = [
        "https://nix-community.cachix.org/"
        "https://cache.nixos.org/"
        "https://cache.iog.io"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
      allow-import-from-derivation = "true";
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "dylan" ];
  };
  
  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    epiphany
    geary
    evince
    totem
    cheese
    yelp
    gnome-calendar
    simple-scan
    gnome-music
    tali
    iagno
    hitori
    atomix
    gnome-weather
    gnome-contacts
    gnome-initial-setup
    gnome-maps
  ];

  services.udev.packages = with pkgs; [
    gnome-settings-daemon
  ];

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };

  system.stateVersion = "24.05";
}
