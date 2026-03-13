{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord
    discord-desktop-mobile
    vesktop # Cliente de escritorio alternativo para Discord, con más funciones y personalización
    ferdium
    telegram-desktop # Cliente oficial de escritorio para la aplicación de mensajería Telegram
    thunderbird # Cliente de correo electrónico, calendario y noticias
    newsflash # Lector de noticias RSS/Atom moderno para el escritorio GNOME
  ];
}
