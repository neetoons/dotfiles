{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obsidian # Editor de notas basado en Markdown que utiliza un enfoque de grafo/red
    sticky-notes # Aplicación de notas adhesivas para el escritorio
    speedcrunch
    onlyoffice-desktopeditors # Suite ofimática con funciones de colaboración
  ];
}
