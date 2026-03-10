{
  description = "Nit's NixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    home-manager = {
        url = "github:nix-community/home-manager/release-25.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
        url = "github:sodiboo/niri-flake";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
        url =  "github:nix-community/stylix/release-25.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
        url = "github:0xc000022070/zen-browser-flake";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
        url = "github:Gerg-L/spicetify-nix";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    elyprismlauncher = {
        url = "github:ElyPrismLauncher/ElyPrismLauncher/10.0.2";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    oxicord = {
        url = "github:linuxmobile/oxicord";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    tibia-nix = {
        url = "github:neetoons/tibia-nix";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

  };

  outputs = {nixpkgs, home-manager, ... }@inputs:
  {


    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/desktop/configuration.nix
          {
            nixpkgs.overlays = [ inputs.niri.overlays.niri ];
            home-manager.useUserPackages = true;
            home-manager = {
              users.nit = {
                  imports = [
                    inputs.spicetify-nix.homeManagerModules.default
                    inputs.stylix.homeModules.stylix
                    inputs.niri.homeModules.niri
                    ./home/nit/home.nix
                  ];
                };
              extraSpecialArgs = {
                  inherit inputs;
              };
            };
          }
        ];
      };
    };
  };
}
