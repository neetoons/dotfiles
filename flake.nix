{
  description = "Nit's NixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
        url = "github:nix-community/home-manager/release-25.11";
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

    hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    stylix = {
        url =  "github:nix-community/stylix/release-25.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    oxicord = {
        url = "github:linuxmobile/oxicord";
        inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = {nixpkgs, home-manager, spicetify-nix, stylix, ... }@inputs:
  let
    system = "x86_64-linux";
    spicetify = spicetify-nix.lib.mkSpicetify;
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/desktop/configuration.nix
          {
            home-manager.useUserPackages = true;
            home-manager = {
              users.nit = {
                  imports = [
                    spicetify-nix.homeManagerModules.default
                    stylix.homeModules.stylix
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
