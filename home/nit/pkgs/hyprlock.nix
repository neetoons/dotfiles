{ pkgs, ... }:
let
  wallpaper = "${pkgs.assets}/share/assets/wallpapers/13.jpg";
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      hide_cursor = true;
      ignore_empty_input = true;
      background = {
        path = wallpaper;
        #blur_passes = 0;
        #blur_size = 0;
      };
    };
  };
}
