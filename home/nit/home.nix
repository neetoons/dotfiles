{ inputs, pkgs, ... }:
{
  imports = [
    ./pkgs/packages.nix
    ./mimeapps.nix
    ./niri/niri.nix
    ./stylix.nix
    ./services/services.nix
  ];

  home.username = "nit";
  home.homeDirectory = "/home/nit";
  home.stateVersion = "25.11";

  home.pointerCursor = {
    package = pkgs.manhattan-cafe;
    name = "ManhattanCafe";
    size = 24;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme.package = pkgs.papirus-icon-theme.override { color = "pink"; };
    iconTheme.name = "Papirus-Dark";
  };

  home.sessionVariables = {
    EDITOR = "${pkgs.neovim}/bin/nvim";
    TERMINAL = "${pkgs.alacritty-graphics}/bin/alacritty";
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "neetoons";
        email = "neet.toons@gmail.com";
      };
    };
  };
  programs.home-manager.enable = true;
}
