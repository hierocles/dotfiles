{ ... }: {
  age = {
    secrets = {
      njalla.file = ./njalla.age;
      wg.file = ./wg.age;
      transmission.file = ./transmission.age;
    };
    identityPaths = [
      "/var/lib/persistent/id_ed25519"
    ];
  };
}