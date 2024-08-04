{ config, lib, pkgs, ... }: {
  
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
      enable = false;
      keysFile = config.age.secrets.njalla.path;
    };

    plex = {
      enable = true;
      expose.https = {
        enable = false;
        domainName = "plex.hierocles.win";
        acmeMail = "4733259+hierocles@users.noreply.github.com";
      };
    };

    transmission = {
      enable = true;
      vpn.enable = true;
      peerPort = 10396;
    };

    bazarr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    sonarr.enable = true;
  };
}