{ pkgs, ... }:
{
  programs = {
    lutris.enable = true;
    mangohud.enable = true;
  };

  home.packages = with pkgs; [
    heroic
    steam
  ];
}
