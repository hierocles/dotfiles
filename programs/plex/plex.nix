{ config, lib, pkgs, services, ... }: {

    services.plex = {
        enable = true;
        openFirewall = true;
        group = "media";
        accelerationDevices = [ "/dev/dri/renderD128" ];
    };
}