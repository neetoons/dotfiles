{ inputs, pkgs, ... }:
{
    imports = [
        ./pkgs/packages.nix
        ./pkgs/spicetify.nix
        ./pkgs/hypridle.nix
        ./pkgs/hyprlock.nix
        ./pkgs/nvim.nix
        ./pkgs/alacritty.nix
        ./pkgs/eww.nix
        #./vscodium/default.nix
        #./swaync.nix
    ];

    home.username = "nit";
    home.homeDirectory = "/home/nit";
    home.stateVersion = "25.11";

    gtk = {
        enable = true;
        cursorTheme.package = pkgs.bibata-cursors;
        cursorTheme.name = "Bibata-Original-Classic";
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


    programs.home-manager.enable = true;
}
