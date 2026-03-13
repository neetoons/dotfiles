{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.elisa # The Elisa music player is developed by the KDE community and strives to be simple and pleasant to use.
    mixxx
    lmms # Estación de trabajo de audio digital (DAW) de código abierto
    gimp # Editor de imágenes y retoque fotográfico avanzado (alternativa a Photoshop)
    audacity # Editor y grabador de audio digital
    pinta # Programa simple para dibujar/editar imágenes, similar a Paint.NET
    gcolor3 # Selector y capturador de color simple para el escritorio
    kdePackages.kdenlive # Editor de video no lineal avanzado
    obs-studio # Software libre y de código abierto para grabación de video y transmisión en vivo
    losslesscut-bin # Editor de video simple para cortes rápidos sin pérdida de calidad
    handbrake
  ];
}
