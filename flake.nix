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
    microvm = {
      url = "github:microvm-nix/microvm.nix";
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
    microvm,
    tnutils,
    stylix,
    niri
  } @inputs:
  let
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};

    defaultModules = [
      ./modules/common.nix
      nixos-cli.nixosModules.nixos-cli
    ];

    proxmoxHostModules = [
      ./modules/proxmox/configuration.nix
    ] ++ defaultModules;
    
    graphicalDesktopModules = [
      ./modules/graphical-desktop
      stylix.nixosModules.stylix
      home-manager.nixosModules.home-manager
      niri.nixosModules.niri
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.extraSpecialArgs = inputs;
        home-manager.users.tnu = import ./users/tnu/home.nix;
      }
    ] ++ defaultModules;
  in {
    packages.${system} = rec {
      default = proxmox;
      proxmox = nixos-generators.nixosGenerate {
        inherit system;
        modules = [
          ./modules/proxmox
          { system.stateVersion = "25.11"; }
        ];
        format = "proxmox";
      };
    };

    nixosConfigurations = {
      bed = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/bed
          microvm.nixosModules.host
        ] ++ defaultModules;
      };
      aster = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/aster
          nixos-hardware.nixosModules.framework-13th-gen-intel
        ] ++ graphicalDesktopModules;
      };
      sunflower = nixpkgs.lib.nixosSystem {
        modules = [
          ./modules/stylix.nix
          ./hosts/sunflower
        ] ++ graphicalDesktopModules;
      };
      tuber = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/tuber
        ] ++ proxmoxHostModules;
      };
      daffodil = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/daffodil
          microvm.nixosModules.microvm
        ] ++ defaultModules;
      };
    };
  };
}
