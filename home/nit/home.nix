{ inputs, pkgs, assets, ... }:
let
  assets = pkgs.callPackage ./pkgs/assets.nix { };
  ManhattanCafe = pkgs.stdenv.mkDerivation rec {
    name = "ManhattanCafe";
    src = assets;
    installPhase = ''
      mkdir -p $out/share/icons/${name}/
     cd share/assets/cursors/${name}
     cp -r cursors index.theme $out/share/icons/${name}/
    '';
  };
in
{

    imports = [
        ./pkgs/packages.nix
        ./pkgs/spicetify.nix
        ./pkgs/hypridle.nix
        ./pkgs/hyprlock.nix
        ./pkgs/nvim.nix
        ./pkgs/alacritty.nix
        ./pkgs/eww.nix
        ./pkgs/mpv.nix
        ./pkgs/waypaper.nix
        ./mimeapps.nix
        ./niri/niri.nix
        #./vscodium/default.nix
        #./swaync.nix
    ];

    home.username = "nit";
    home.homeDirectory = "/home/nit";
    home.stateVersion = "25.11";



    #home.pointerCursor = {
    #  package = manhattan-cafe;
    #  name = "manhattan-cafe"; # Debe coincidir con el nombre de la carpeta en share/icons
    #  size = 24;

    #  # Esto aplica el cursor a aplicaciones GTK y de sistema
    #  gtk.enable = true;
    #  #x11.enable = true;
    #};

home.pointerCursor = {
  package = ManhattanCafe;
  name = "ManhattanCafe"; # Debe coincidir con el nombre de la carpeta en share/icons
  size = 24;

  # Esto aplica el cursor a aplicaciones GTK y de sistema
  gtk.enable = true;
};


    gtk = {
        enable = true;
        #cursorTheme.package = pkgs.bibata-cursors;
        #cursorTheme.package = manhattan-cafe;
        #cursorTheme.name = "Bibata-Original-Classic";
        #cursorTheme.name = "manhattan-cafe";
        iconTheme.package = pkgs.papirus-icon-theme.override { color = "pink"; };
        iconTheme.name = "Papirus-Dark";
    };

    home.sessionVariables = {
        EDITOR = "${pkgs.neovim}/bin/nvim";
        #VISUAL = "${pkgs.zed-editor}/bin/zed-editor";
        TERMINAL = "${pkgs.alacritty-graphics}/bin/alacritty";
    };

    stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        polarity = "dark";
    };

    #git = {
    #    enable = true;
    #    userName = "neetzeek";
    #    userEmail = "neet.toons@email.com";
    #    extraConfig.init.defaultBranch = "main";
    #};

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
