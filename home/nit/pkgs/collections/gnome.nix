{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-logs
    gnome-clocks
    gnome-font-viewer
    gnome-decoder
    gnome-solanum # Aplicación de temporizador Pomodoro para gestionar el tiempo
  ];
}
