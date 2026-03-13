{ pkgs, ... }:
{
  home.packages = with pkgs; [
    anki-bin # Programa de tarjetas de memoria (flashcards) para el aprendizaje
    bleachbit # Herramienta de limpieza del sistema para liberar espacio y preservar la privacidad
    contrast # Herramienta para verificar el contraste de colores para la accesibilidad web
    wordbook # Aplicación para aprender y gestionar vocabulario
    dialect # Aplicación simple de traducción de idiomas
    rofimoji
    pika-backup # Herramienta de copia de seguridad simple basada en BorgBackup
    qbittorrent # Cliente BitTorrent moderno y liviano
    nicotine-plus # Cliente para la red de intercambio de archivos Soulseek (SLSK)
    p7zip # Utilidad para comprimir y descomprimir archivos en formato 7z
    peazip
    rclone-ui
    warehouse
    quickemu # Herramienta para crear y ejecutar máquinas virtuales QEMU de forma rápida
    qemu # Emulador y virtualizador de máquinas
    lmstudio # ia
    qutebrowser
    protonup-qt
    recorder
    pawncc
    #net-tools
  ];
}
