{
  description = "general system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cli = {
      url = "github:nix-community/nixos-cli/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tnutils = {
      url = "github:theNextUsername/theNextUtils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    nixos-cli,
    nixos-generators,
    tnutils,
    stylix,
    niri
  } @inputs:
  let
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = rec {
      default = proxmox;
      proxmox = nixos-generators.nixosGenerate {
        inherit system;
        modules = [
          {
            system.stateVersion = "25.11";
          }
          ./modules/proxmox
        ];
      };
    };
    nixosConfigurations = {
      aster = nixpkgs.lib.nixosSystem {
        modules = [
          ./modules/common.nix
          ./modules/graphical-desktop
          ./hosts/aster
          stylix.nixosModules.stylix
          nixos-hardware.nixosModules.framework-13th-gen-intel
          home-manager.nixosModules.home-manager
          nixos-cli.nixosModules.nixos-cli
          niri.nixosModules.niri
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = inputs;
            home-manager.users.tnu = import ./users/tnu/home.nix;
          }
        ];
      };
      sunflower = nixpkgs.lib.nixosSystem {
        modules = [
          ./modules/common.nix
          ./modules/stylix.nix
          ./modules/graphical-desktop
          ./hosts/sunflower
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          nixos-cli.nixosModules.nixos-cli
          niri.nixosModules.niri
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = inputs;
            home-manager.users.tnu = import ./users/tnu/home.nix;
          }
        ];
      };
      tuber = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/tuber
          ./modules/proxmox
          ./modules/common.nix
          nixos-cli.nixosModules.nixos-cli
        ];
      };
    };
  };
}
