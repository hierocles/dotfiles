{
  description = "Constellation homelab and media server NixOS config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixarr.url = "github:hierocles/nixarr/add-plex-support";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
  };

  outputs = { self, home-manager, nixpkgs, agenix, nixarr, ... }:
  let
      overlays = [ ];
      homeManagerConfFor = config:
        { ... }: {
          nixpkgs.overlays = overlays;
          imports = [ config ];
        };
    in {
      nixosConfigurations.constellation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/constellation/configuration.nix
          nixarr.nixosModules.default
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.users.dylan =
              homeManagerConfFor ./hosts/constellation/home.nix;
          }
          {
            environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
          }
        ];
        specialArgs = { inherit nixpkgs; };
      };
    };
}
