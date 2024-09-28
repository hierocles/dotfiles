{ config, pkgs, ... }: {
  
  environment.systemPackages = with pkgs; [
    recyclarr
  ];

  environment.etc."wg.conf".source = config.age.secrets.wg.path;

  nixarr = {
    enable = true;
    mediaDir = "/datapool";
    stateDir = "/data/.state/nixarr";

    vpn = {
      enable = true;
      wgConf = "/etc/wg.conf";
    };

    plex = {
      enable = true; #34200
      openFirewall = true;
    };

    transmission = {
      enable = true; #9091
      vpn.enable = true;
      peerPort = 10396;
      flood.enable = true;
      credentialsFile = config.age.secrets.transmission.path;
      extraAllowedIps = [ "192.168.*.*" ];
    };

    bazarr.enable = true; #6767
    prowlarr.enable = true; #9696
    radarr.enable = true; #7878
    sonarr.enable = true; #8989
  };

  services.jellyseerr = {
    enable = true; #5055
    openFirewall = true;
  };
}