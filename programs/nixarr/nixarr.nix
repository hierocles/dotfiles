{ config, lib, pkgs, ... }: {
  
  environment.systemPackages = with pkgs; [
    recyclarr
  ];

  environment.etc."wg.conf".source = config.age.secrets.wg.path;

  nixarr = {
    enable = true;
    mediaDir = "/datapool/subvol-100-disk-2";
    stateDir = "/data/.state/nixarr";

    vpn = {
      enable = true;
      wgConf = "/etc/wg.conf";
      openTcpPorts = [ 10396 ];
      openUdpPorts = [ 10396 ];
      vpnTestService.enable = true;
      vpnTestService.port = 10396;
    };

    ddns.njalla = {
      enable = true;
      keysFile = config.age.secrets.njalla.path;
    };

    plex = {
      enable = true; #34200
      #vpn.enable = true;
      #expose.vpn = {
      #  accessibleFrom = "plex.hierocles.win";
      #  port = 10396;
      #};
      expose.https = {
        enable = true;
        domainName = "plex.hierocles.win";
        acmeMail = "4733259+hierocles@users.noreply.github.com";
      };
    };

    transmission = {
      enable = true; #9091
      vpn.enable = true;
      peerPort = 10396;
      flood.enable = true;
      credentialsFile = config.age.secrets.transmission.path;
    };

    bazarr.enable = true; #6767
    prowlarr.enable = true; #9696
    radarr.enable = true; #7878
    sonarr.enable = true; #8989
  };

  #services.flaresolverr = {
  #  enable = true;
  #  port = 8191;
  #  openFirewall = true;
  #};

  services.jellyseerr = {
    enable = true; #5055
    openFirewall = true;
  };
}