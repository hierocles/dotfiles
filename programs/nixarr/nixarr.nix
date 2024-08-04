{ config, lib, pkgs, ... }: {
  nixarr = {
    enable = true;
    mediaDir = "/datapool/subvol-100-disk-2";
    stateDir = "/data/.state/nixarr";

    vpn = {
      enable = true;
      wgConf = "/data/.secrets/wg.conf";
    };

    ddns.njalla = {
      enable = true;
      keysFile = "/data/.secrets/njalla/keys-file.json";
    };

    jellyfin = {
      enable = true;
      # These options set up a nginx HTTPS reverse proxy, so you can access
      # Jellyfin on your domain with HTTPS
      expose.https = {
          enable = true;
          domainName = "your.domain.com";
          acmeMail = "your@email.com"; # Required for ACME-bot
      };
    };

    transmission = {
      enable = true;
      vpn.enable = true;
      peerPort = 50000; # Set this to the port forwarded by your VPN
    };

    # It is possible for this module to run the *Arrs through a VPN, but it
    # is generally not recommended, as it can cause rate-limiting issues.
    bazarr.enable = true;
    lidarr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    readarr.enable = true;
    sonarr.enable = true;
  };
}