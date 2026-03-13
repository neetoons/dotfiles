{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-logs
    gnome-clocks
    gnome-font-viewer
    gnome-decoder
    gnome-keyring # is a secure, encrypted daemon for GNOME that stores user credentials, passwords, keys, and certificates, typically unlocking automatically upon user login. It acts as a secret service, providing, for instance, org.freedesktop.secrets for applications.
    gnome-solanum # Aplicación de temporizador Pomodoro para gestionar el tiempo
  ];
}
