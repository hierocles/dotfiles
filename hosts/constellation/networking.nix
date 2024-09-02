{ ... }: {
  networking = {
    hostName = "constellation";
    hostId = "e1a8512a";
    enableIPv6 = false;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [ "docker0" ];
      allowedTCPPorts = [ 80 443 10396 ];
      allowedUDPPorts = [ 10396 ];
    };
  };
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    port = 3000;
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "4733259+hierocles@users.noreply.github.com";
  };
}