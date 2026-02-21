{
  description = "general system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    
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
    disko = {
      url = "github:nix-community/disko/latest";
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
    disko,
    tnutils,
    stylix,
    niri
  } @inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

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
      opentelemetry-collector-builder = pkgs.callPackage ./packages/opentelemetry-collector/builder.nix {};
      opentelemetry-collector-releases = pkgs.callPackage ./packages/opentelemetry-collector/releases.nix {
        opentelemetry-collector-builder = self.packages.${system}.opentelemetry-collector-builder;
      };
    };

    nixosConfigurations = {
      bed = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self; };
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
      lily = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/lily
        ] ++ proxmoxHostModules;
      };     
      daffodil = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/daffodil
          microvm.nixosModules.microvm
        ] ++ defaultModules;
      };
      peony = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/peony 
        ] ++ proxmoxHostModules;
      };
      ns1 = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/ns1
        ] ++ proxmoxHostModules;
      };
      nepenthes = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self; };
        modules = [
          ./hosts/nepenthes
          {
            nixpkgs.overlays = [
              (import ./overlays/opentelemetry.nix)
            ];
          }
        ] ++ proxmoxHostModules;
      };


      # lan hosts
      finbar = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/finbar
          disko.nixosModules.disko          
        ] ++ defaultModules;
      };
    };
  };
}
