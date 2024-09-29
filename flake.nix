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
    nixpkgs-update = {
      url = "github:nix-community/nixpkgs-update";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { 
    self, 
    home-manager, 
    nixpkgs, 
    nixarr,
    agenix,
    nixpkgs-update,
    nur,
    nix-vscode-extensions,
    alejandra,
    ... }@inputs:
  let
      system = "x86_64-linux";
      overlays = [ 
        inputs.nix-vscode-extensions.overlays.default
        inputs.nur.overlay
      ];
      homeManagerConfFor = config:
        { ... }: {
          nixpkgs.overlays = overlays;
          imports = [ config ];
        };
    in {
      nixosConfigurations.constellation = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/constellation/configuration.nix
          ./secrets/files.nix
          nixarr.nixosModules.default
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.users.dylan =
              homeManagerConfFor ./hosts/constellation/home.nix;
          }
          {
            environment.systemPackages = [ 
              agenix.defaultPackage.${system}
              nixpkgs-update
              alejandra.defaultPackage.${system}
            ];
          }
        ];
        specialArgs = { inherit nixpkgs; };
      };
    };
}
