{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sherlock # Herramienta para buscar perfiles de usuario en múltiples redes sociales
    yazi
    zip # Utilidad de línea de comandos para crear archivos comprimidos .zip
    unzip # Utilidad de línea de comandos para extraer archivos .zip
    tty-clock
    cava
    zellij
    rclone # Herramienta de sincronización de archivos con servicios de almacenamiento en la nube
    ncdu # Analizador de uso de disco en modo consola/terminal
    bottom
    btop # Monitor de recursos del sistema con una interfaz visual y atractiva
    unrar-wrapper # Utilidad para extraer archivos comprimidos en formato RAR
    tree # Utilidad de línea de comandos para listar contenido de directorios en formato de árbol
    jq # Procesador ligero y flexible de JSON en línea de comandos
    wget # Utilidad de línea de comandos para descargar archivos desde la web
    fzf # Buscador difuso (fuzzy finder) de línea de comandos
    fastfetch # Herramienta de línea de comandos para mostrar información del sistema y el logo de la distribución
    disfetch
    qdirstat # Herramienta gráfica para visualizar el uso del disco
    fd
    gh
    ffmpeg # Marco multimedia para procesar, convertir y transmitir audio/video
    yt-dlp # Descargador de videos de YouTube y otros sitios (sucesor de youtube-dl)
    sorter
  ];
}
