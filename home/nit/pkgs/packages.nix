{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    inputs.oxicord.packages.${system}.default
    inputs.elyprismlauncher.packages.${system}.default
  ];

  imports = [
    ./spicetify.nix
    ./swaylock.nix
    ./swayidle.nix
    ./nvim.nix
    ./alacritty.nix
    ./eww.nix
    ./mpv.nix
    ./mpvpaper.nix
    ./mangohud.nix
    ./gammastep.nix
    ./collections/communication.nix
    ./collections/dev.nix
    ./collections/utilities.nix
    ./collections/gaming.nix
    ./collections/gnome.nix
    ./collections/media.nix
    ./collections/office.nix
    ./collections/terminal.nix
  ];
}
