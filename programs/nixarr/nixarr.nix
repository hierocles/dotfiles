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

    #ddns.njalla.vpn = {
    #  enable = true;
    #  keysFile = config.age.secrets.njalla.path;
    #};

    plex = {
      enable = true; #34200
      #vpn.enable = true;
      #expose.vpn = {
      #  accessibleFrom = "plex.hierocles.win";
      #  port = 10396;
      #};
      #expose.https = {
      #  enable = true;
      #  domainName = "plex.hierocles.win";
      #  acmeMail = "4733259+hierocles@users.noreply.github.com";
      #};
    };

    transmission = {
      enable = true; #9901
      vpn.enable = true;
      peerPort = 10396;
      
    };

    bazarr.enable = true; #6767
    prowlarr.enable = true; #9696
    radarr.enable = true; #7878
    sonarr.enable = true; #8989
  };
}