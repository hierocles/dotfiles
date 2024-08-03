{
  description = "Constellation homelab and media server NixOS config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
  };

  outputs = { home-manager, nixpkgs, nur, ... }:
  let
      overlays = [ nur.overlay ];
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
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.users.dylan =
              homeManagerConfFor ./hosts/constellation/home.nix;
          }
        ];
        specialArgs = { inherit nixpkgs; };
      };
    };
}
