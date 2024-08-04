{ config, lib, pkgs, ... }: {
  age.secrets = {
    njalla.file = ./njalla.age;
    wg.file = ./wg.age;
  };
}