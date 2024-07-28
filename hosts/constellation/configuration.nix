{ config, lib, nixpkgs, pkgs, ... }: {
  imports = [ 
    ./hardware-configuration.nix
    ../../programs/non-free.nix
    ];

  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
        zfsSupport = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    initrd.kernelModules = [
      "zfs"
      "i915"
    ];
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    supportedFilesystems = [ "zfs" ];
    zfs.extraPools = [ "datapool" ];
  };

  services.zfs.autoScrub.enable = true;


  time.timeZone = "America/New_York";

  networking = {
    interfaces = {
      enp3s0.ipv4.addresses = [{
        address = "10.0.0.1";
        prefixLength = 24;
      }];
    };
    useDHCP = false;
    hostName = "constellation";
    networkmanager.enable = true;
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  programs.waybar.enable = true;
  programs.zsh.enable = true;
  services.xserver = {
    enabled = true;
    layout = "us";
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver vaapiVdpau libvdpau-va-gl ];
  };

  environment.variables = {
    VDPAU_DRIVER = "va_gl";
    LIBVA_DRIVER_NAME = "iHD";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  users.users.dylan = {
    isNormalUser = true;
    createHome = true;
    group = "dylan";
    extraGroups =
      [ "wheel" "users" "networkmanager" ];
    home = "/home/dylan";
    uid = 1000;
    shell = pkgs.zsh;
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    nixPath = [ "nixpkgs=${nixpkgs}" ];
    registry.nixpkgs.flake = nixpkgs;
    package = pkgs.nixUnstable;
    settings = {
      substituters = [
        "https://nix-community.cachix.org/"
        "https://cache.nixos.org/"
        "https://cache.iog.io"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      allow-import-from-derivation = "true";
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CascadiaCode" "FiraCode" ]; })
  ];

  environment.systemPackages = with pkgs;
    [
      alacritty
      binutils
      wget
      intel-gpu-tools
      killall
      libva-utils
      docker-compose
      cmake
      gcc
      gnumake
      libtool
      vdpauinfo
      dunst
      direnv
      feh
    ] ++ [
      glib
      grimb
      slurp
      wayland
      wl-clipboard
      wdisplays
    ];

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "docker0" ];
    allowedTCPPorts = [ 17500 ];
    allowedUDPPorts = [ 17500 ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  system.stateVersion = "24.05";
}
