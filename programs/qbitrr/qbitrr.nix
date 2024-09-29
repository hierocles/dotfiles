{ pkgs, ... }:

let
  python = pkgs.python3.override {
    packageOverrides = pyfinal: pyprev: {
      qbitrr2 = pyprev.callPackage ../../packages/qbitrr2.nix {};
    };
  };
  pythonWithQbitrr2 = python.withPackages (ps: [ ps.qbitrr2 ]);
in
{
  systemd.services.qbitrr2 = {
    description = "qbitrr2 service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pythonWithQbitrr2}/bin/python -m qbitrr";
      Restart = "always";
      DynamicUser = true;
      StateDirectory = "qbitrr";
      WorkingDirectory = "/var/lib/qbitrr";
      Environment = "CONFIG_FILE=/var/lib/qbitrr/config.toml;CONFIG_PATH=/var/lib/qbitrr";
    };
  };

  # Ensure the config file is in place
  system.activationScripts = {
    setupQbitrr2 = {
      text = ''
        mkdir -p /var/lib/qbitrr
        cp -n ${./config.toml} /var/lib/qbitrr/config.toml
        chmod 644 /var/lib/qbitrr/config.toml
      '';
      deps = [];
    };
  };
}