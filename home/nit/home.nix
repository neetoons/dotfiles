{ inputs, pkgs, ... }:
{
    imports = [
        ./pkgs/packages.nix
        ./spicetify/default.nix
        ./hypr/hypridle/default.nix
        ./hypr/hyprlock/default.nix
        ./vscodium/default.nix
        ./nvim/default.nix
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
        VISUAL = "${pkgs.zed-editor}/bin/zed-editor";
    };

    stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        polarity = "dark";
    };

    #home-manager.users.nit.services.kdeconnect.enable = true;

    programs.home-manager.enable = true;
}
