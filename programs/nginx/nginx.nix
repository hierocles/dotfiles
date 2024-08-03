{ config, lib, pkgs, services, ... }: {
  imports = [
      ./plex.nix
  ];

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "4733259+hierocles@users.noreply.github.com";
  services.nginx = {
      enable = true;
  };
}